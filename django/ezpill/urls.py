from django.urls import path
from . import views
from .views import UserListCreateView, UserDetailView, ProductVitaminBListAPIView, ProductOmega3ListAPIView,ProductVitaminDListAPIView,ProductCalciumListAPIView,ProductCollagenListAPIView,ProductFolicAcidListAPIView,ProductIronListAPIView,ProductLuteinListAPIView,ProductMagnesiumListAPIView,ProductProbioticListAPIView

urlpatterns = [
    path('get-product-info/<int:product_id>/', views.get_product_info, name='get_product_info'),
    path('api/users/', UserListCreateView.as_view(), name='user-list'),
    path('api/users/<int:pk>/', UserDetailView.as_view(), name='user-detail'),
    path('api/products/비타민B/', ProductVitaminBListAPIView.as_view(), name='product-vitaminb-list'),
    path('api/products/오메가3/', ProductOmega3ListAPIView.as_view(), name='product-omega3-list'),
    path('api/products/비타민D/', ProductVitaminDListAPIView.as_view(), name='product-vitamind-list'),
    path('api/products/칼슘/', ProductCalciumListAPIView.as_view(), name='product-calcium-list'),
    path('api/products/콜라겐/', ProductCollagenListAPIView.as_view(), name='product-collagen-list'),
    path('api/products/엽산/', ProductFolicAcidListAPIView.as_view(), name='product-folicacid-list'),
    path('api/products/철분/', ProductIronListAPIView.as_view(), name='product-iron-list'),
    path('api/products/루테인/', ProductLuteinListAPIView.as_view(), name='product-lutein-list'),
    path('api/products/마그네슘/', ProductMagnesiumListAPIView.as_view(), name='product-magnesium-list'),
    path('api/products/유산균/', ProductProbioticListAPIView.as_view(), name='product-probiotic-list'),
    
]