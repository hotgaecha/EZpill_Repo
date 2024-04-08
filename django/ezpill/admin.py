from django.contrib import admin
from .models import User, Survey, Basket, Product, ProductVitaminB, ProductVitaminD, ProductCalcium, ProductCollagen, ProductFolicAcid, ProductIron, ProductLutein, ProductMagnesium, ProductOmega3, ProductProbiotic


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['user_id', 'phone', 'email', 'password', 'created_date']


@admin.register(Survey)
class SurveyAdmin(admin.ModelAdmin):
    list_display = ['survey_id', 'user_id', 'preg_week', 'age', 'bmi', 'medication', 'sea_food_allergy', 'probiotic_allergy', 'collagen_allergy', 'lutein_allergy', 'diabetes', 'high_blood_pressure', 'heart_disease', 'budget']


@admin.register(Basket)
class BasketAdmin(admin.ModelAdmin):
    list_display = ['basket_id', 'user', 'pill_1', 'pill_2', 'pill_3', 'pill_4', 'pill_5', 'pill_6', 'pill_7', 'pill_8', 'pill_9', 'pill_10']


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['product_id', 'image_url', 'product_title', 'product_manufacture', 'product_price', 'product_per_price', 'product_usage', 'product_precautions', 'product_ingredient_information', 'review']


@admin.register(ProductVitaminB)
class ProductVitaminBAdmin(admin.ModelAdmin):
    list_display = ['product_id', 'image_url', 'product_title', 'product_manufacture', 'product_price', 'product_per_price', 'product_usage', 'product_precautions', 'product_ingredient_information', 'review', 'vitamin_b_id']


@admin.register(ProductVitaminD)
class ProductVitaminDAdmin(admin.ModelAdmin):
    list_display = ['product_id', 'image_url', 'product_title', 'product_manufacture', 'product_price', 'product_per_price', 'product_usage', 'product_precautions', 'product_ingredient_information', 'review', 'vitamin_d_id']
