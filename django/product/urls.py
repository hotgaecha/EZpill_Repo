from django.urls import path
from . import views

urlpatterns = [
    path('list/', views.product_list, name='product_list'),
    # 여기에 다른 URL 패턴 추가
]
