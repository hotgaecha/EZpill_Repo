from rest_framework import serializers
from .models import User, ProductVitaminB, ProductOmega3,ProductVitaminD,ProductCalcium,ProductCollagen,ProductFolicAcid,ProductIron,ProductLutein,ProductMagnesium,ProductProbiotic

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'  # 혹은 원하는 필드 목록을 나열할 수 있습니다.
class ProductVitaminBSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductVitaminB
        fields = '__all__'
class ProductOmega3Serializer(serializers.ModelSerializer):
    class Meta:
        model = ProductOmega3
        fields = '__all__'

class ProductVitaminDSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductVitaminD
        fields = '__all__'

class ProductCalciumSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCalcium
        fields = '__all__'

class ProductCollagenSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductCollagen
        fields = '__all__'

class ProductFolicAcidSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductFolicAcid
        fields = '__all__'

class ProductIronSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductIron
        fields = '__all__'

class ProductLuteinSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductLutein
        fields = '__all__'

class ProductMagnesiumSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductMagnesium
        fields = '__all__'

class ProductProbioticSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductProbiotic
        fields = '__all__'