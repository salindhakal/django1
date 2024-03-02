

from django.contrib import admin
from django.urls import path, include 
from django.views.generic import RedirectView
from TouristSite.views import recommend_places

urlpatterns = [
    path('admin/', admin.site.urls),
    path('TouristSite/', include('TouristSite.urls')),
    path('recommend_places/', recommend_places),
    # Redirect the root URL to your app
    path('', RedirectView.as_view(url='TouristSite/')),
]