from django.urls import path
from . import views

urlpatterns = [
    path('api/basket2/<str:firebase_uid>/', views.basket2_list, name='basket2_list'),
    # 여기에 다른 URL 패턴 추가
]
