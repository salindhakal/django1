from rest_framework import serializers
from .models import TourismSite

class TourismSiteSerializer(serializers.ModelSerializer):
    class Meta:
        model= TourismSite
        fields= '__all__'