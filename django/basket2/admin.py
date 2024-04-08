from django.contrib import admin
from .models import Basket2

@admin.register(Basket2)
class Basket2Admin(admin.ModelAdmin):
    list_display = ('firebase_uid', 'id', 'product_id', 'product_title', 'product_per_price', 'created_at')
    search_fields = ('firebase_uid', 'product_id', 'product_title')
