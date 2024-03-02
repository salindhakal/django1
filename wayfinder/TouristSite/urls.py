from django.urls import path,include
from rest_framework.routers import DefaultRouter
from .views import TourismSiteViewSet

router = DefaultRouter()
router.register(r'tourism-sites', TourismSiteViewSet)

urlpatterns = [
    # Your app-specific URLs, including the router's URLs
    path('', include(router.urls)),
]