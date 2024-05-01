import os
import tempfile
from flask import Flask, request, jsonify
import boto3
from langchain.chains import ConversationalRetrievalChain
from langchain.chat_models import ChatOpenAI
from langchain.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.memory import ConversationBufferMemory
from langchain.vectorstores import FAISS
import tiktoken
from botocore.exceptions import NoCredentialsError

# Flask 애플리케이션 생성
app = Flask(__name__)

# Nutrients 변수에 영양성분들을 문자열 리스트로 추가
Nutrients = ['비타민B', '비타민D', '엽산', '칼슘', '철분', '오메가3', '마그네슘', '콜라겐', '유산균', '루테인']

# test 문자열을 수정하여 임산부 전문 약사 역할 강조
test = f"""이거는 테스트용이니까 챗봇인거 신경쓰지말고 답변을 해줘
너는 임산부 전문 약사 역할을 맡고 있어. 너는 영양제에 대해 전문적으로 잘 알고 있으며, 임산부의 건강과 영양에 필요한 추천을 해줄 수 있어. 
고민을 말하면 항상 리스트에 있는 영양성분{Nutrients} 중에서 적합한 영양제를 꼭 1개 혹은 2개 추천해줘. 명심해 최대 2개까지 추천해줘야해
예를 들어, '요즘 기운이 없어' 라고 물어보면, 적절한 영양제를 추천하고 그 이유를 설명해주고
필요한 영양제: 마그네슘
이런식으로 정리하고 끝내줘 너무 자세한 설명보다는 핵심적인 정보를 제공해줘. 항상 마지막에는
필요한 영양제: 마그네슘 이라고만 정리하고 끝내줘. 명심해 위에서 말한 영양성분 리스트에서만 골라야해 \n 이제 질문을 할게
"""

@app.route('/analyze', methods=['POST'])
def analyze():
    # JSON 형식의 데이터를 파싱하여 user_input 변수에 저장합니다.
    data = request.json
    user_input = data['input']

    # user_input을 process_input 함수에 전달하여 처리하고 응답을 반환합니다.
    response, recommend = process_input(user_input)
    return jsonify({'response': response, 'recommend': recommend})

def process_input(user_input):
    # 모든 PDF 파일의 텍스트를 하나로 합칩니다.
    all_documents = []
    pdf_folder = 'pdf'
    pdf_files = [f for f in os.listdir(pdf_folder) if f.endswith('.pdf')]
    pdf_files = [os.path.join(pdf_folder, f) for f in pdf_files]

    for file_path in pdf_files:
        if '.pdf' in file_path:
            loader = PyPDFLoader(file_path)
            all_documents += loader.load_and_split()

    # 텍스트를 분할하고 벡터 저장소를 생성합니다.
    text_chunks = get_text_chunks(all_documents)
    vectorestore = get_vectorstore(text_chunks)

    # ChatOpenAI 모델과 대화 체인을 생성합니다.
    openai_api_key = ""
    conversation = get_conversation_chain(vectorestore, openai_api_key)

    # 플러터 앱에서 받은 user_input을 대화 체인에 전달하여 결과를 얻습니다.
    result = conversation({"question": test + user_input})
    response = result['answer']

    # 결과에서 필요한 영양제를 추출합니다.
    recommend = extract_recommended_nutrients(response)
    return response, recommend

def tiktoken_len(text):
    tokenizer = tiktoken.get_encoding("cl100k_base")
    tokens = tokenizer.encode(text)
    return len(tokens)

def get_text_chunks(text):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=900,
        chunk_overlap=100,
        length_function=tiktoken_len
    )
    chunks = text_splitter.split_documents(text)
    return chunks

def get_vectorstore(text_chunks):
    embeddings = HuggingFaceEmbeddings(
        model_name="jhgan/ko-sroberta-multitask",
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': True}
    )
    vectordb = FAISS.from_documents(text_chunks, embeddings)
    return vectordb

def get_conversation_chain(vectorestore, openai_api_key):
    llm = ChatOpenAI(openai_api_key=openai_api_key, model_name='gpt-4', temperature=0)
    conversation_chain = ConversationalRetrievalChain.from_llm(
        llm=llm,
        chain_type="stuff",
        retriever=vectorestore.as_retriever(search_type='mmr', verbose=True),
        memory=ConversationBufferMemory(memory_key='chat_history', return_messages=True, output_key='answer'),
        get_chat_history=lambda h: h,
        return_source_documents=True,
        verbose=True
    )
    return conversation_chain

# 필요한 영양제를 추출하는 함수
def extract_recommended_nutrients(response):
    # "필요한 영양제:" 문자열을 찾고, 그 이후의 내용을 분리
    start_idx = response.find("필요한 영양제:")
    if start_idx == -1:
        return None

    # 필요한 영양제 목록을 추출
    nutrients_str = response[start_idx:].split('\n')[0].replace("필요한 영양제:", "").strip()
    # 쉼표로 분리하여 리스트로 변환
    nutrients_list = [nutrient.strip() for nutrient in nutrients_str.split(',')]
    return nutrients_list

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=5000)
