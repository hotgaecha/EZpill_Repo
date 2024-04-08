from django.contrib import admin
from .models import Product

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_id', 'product_title', 'product_manufacture', 'product_price')
    search_fields = ('product_title', 'product_manufacture')
