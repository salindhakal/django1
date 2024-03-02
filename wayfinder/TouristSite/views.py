from django.shortcuts import render
from .serializers import TourismSiteSerializer
from .models import TourismSite
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.decorators import api_view

# Create your views here.

#View set code
class TourismSiteViewSet(viewsets.ModelViewSet):
    queryset = TourismSite.objects.all()
    serializer_class=TourismSiteSerializer

#recommendation algorithm view

@api_view(['POST'])
def recommend_places(request):
    selected_interests = request.data.get('options', [])
    all_sites = TourismSite.objects.all()
    recommended_sites = []

    for site in all_sites:
        relevance_score = 0
        for interest in selected_interests:
            if getattr(site, interest, False):
                relevance_score += 1
        if relevance_score > 0:
            recommended_sites.append({"name": site.name,
                                      "description": site.description,
                                       "relevance_score": relevance_score})

    recommended_sites.sort(key=lambda x: x["relevance_score"], reverse=True)
    return Response(recommended_sites)
