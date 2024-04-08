from django.urls import path
from .views import survey_response  # survey_response 뷰를 가져옵니다.

urlpatterns = [
    path('submit/', survey_response, name='survey_response'),  # 'submit/' 경로에 뷰를 연결합니다.
]
