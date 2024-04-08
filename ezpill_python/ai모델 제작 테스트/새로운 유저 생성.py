import mysql.connector
import random
import string

def generate_random_phone():
    return f"010-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"

def generate_random_email():
    username = ''.join(random.choice(string.ascii_lowercase) for _ in range(8))
    return f"{username}@naver.com"

def generate_random_password():
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for _ in range(10))
def add_user():
    # 데이터베이스 연결 정보
    db_config = {
        "host": "qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
        "user": "BAEKI",
        "password": "qoqorlxo1!",
        "database": "Ezpill"
    }
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # 새로운 사용자 추가
    phone_value = generate_random_phone()
    email_value = generate_random_email()
    password_value = generate_random_password()

    cursor.execute(f"""INSERT INTO user 
    (phone, email, password, created_date) 
    VALUES 
    (
      '{phone_value}',
      '{email_value}',
      '{password_value}',
      CURRENT_TIMESTAMP
    );""")

    cursor.execute("SELECT * FROM user ORDER BY user_id DESC LIMIT 1;")
    last_user = cursor.fetchone()
    print("마지막으로 추가된 사용자:", last_user)


    # 연결 종료
    conn.commit()
    cursor.close()
    conn.close()

add_user()
