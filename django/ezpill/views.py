from rest_framework import generics
from django.http import JsonResponse
from .models import User, ProductVitaminB,ProductOmega3,ProductVitaminD,ProductCalcium,ProductCollagen,ProductFolicAcid,ProductIron,ProductLutein,ProductMagnesium,ProductProbiotic,Product
from .serializers import UserSerializer, ProductVitaminBSerializer,ProductOmega3Serializer,ProductVitaminDSerializer,ProductCalciumSerializer,ProductCollagenSerializer,ProductFolicAcidSerializer,ProductIronSerializer,ProductLuteinSerializer,ProductMagnesiumSerializer,ProductProbioticSerializer

class UserListCreateView(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class ProductVitaminBListAPIView(generics.ListAPIView):
    queryset = ProductVitaminB.objects.all()
    serializer_class = ProductVitaminBSerializer

class ProductOmega3ListAPIView(generics.ListAPIView):
    queryset = ProductOmega3.objects.all()
    serializer_class = ProductOmega3Serializer

class ProductVitaminDListAPIView(generics.ListAPIView):
    queryset = ProductVitaminD.objects.all()
    serializer_class = ProductVitaminDSerializer

class ProductCalciumListAPIView(generics.ListAPIView):
    queryset = ProductCalcium.objects.all()
    serializer_class = ProductCalciumSerializer

class ProductCollagenListAPIView(generics.ListAPIView):
    queryset = ProductCollagen.objects.all()
    serializer_class = ProductCollagenSerializer
    
class ProductFolicAcidListAPIView(generics.ListAPIView):
    queryset = ProductFolicAcid.objects.all()
    serializer_class = ProductFolicAcidSerializer

class ProductIronListAPIView(generics.ListAPIView):
    queryset = ProductIron.objects.all()
    serializer_class = ProductIronSerializer

class ProductLuteinListAPIView(generics.ListAPIView):
    queryset = ProductLutein.objects.all()
    serializer_class = ProductLuteinSerializer

class ProductMagnesiumListAPIView(generics.ListAPIView):
    queryset = ProductMagnesium.objects.all()
    serializer_class = ProductMagnesiumSerializer

class ProductProbioticListAPIView(generics.ListAPIView):
    queryset = ProductProbiotic.objects.all()
    serializer_class = ProductProbioticSerializer 

# def product_vitamin_b_api(request):
#     search_term = request.GET.get('search', '')
#     print("Search Term:", search_term)  # 검색어 출력
    
#     # 'vitamin b'를 포함하는 제품 검색
#     products = ProductVitaminB.objects.filter(product_title__icontains=search_term)
    
#     serialized_products = [{
#         'image_url': product.image_url,
#         'product_title': product.product_title,
#         'product_manufacture': product.product_manufacture,
#         'product_price': product.product_price,
#         # 필요한 필드들 추가
#     } for product in products]

#     return JsonResponse({'products': serialized_products})



def get_product_info(request, product_id):
    try:
        product = Product.objects.get(product_id=product_id)
        product_info = {
            'product_id': product.product_id,
            'product_title': product.product_title,
            'product_price': product.product_price,
            'product_per_price': product.product_per_price,
            'product_usage': product.product_usage,
            'product_precautions': product.product_precautions,
            'product_ingredient_information': product.product_ingredient_information,
            'review': product.review,
            # 필요한 필드들 추가
        }
        return JsonResponse(product_info)
    except Product.DoesNotExist:
        return JsonResponse({'error': 'Product not found'}, status=404) 