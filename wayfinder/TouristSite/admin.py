from django.contrib import admin
from .models import TourismSite
# Register your models here.
@admin.register(TourismSite)
class TourismSiteAdmin(admin.ModelAdmin):
    # Optionally, you can specify fields to display in the admin interface
    list_display = ['name', 'location','description', 'nature', 'culture', 'adventure']