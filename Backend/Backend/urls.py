"""Backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""


from django.contrib import admin
from django.urls import path, include, re_path
from . import views
from regions.views import *
from empresa.views import *

urlpatterns = [
    re_path('admin/', admin.site.urls),
    re_path('api/', include('api.urls')),
    path('regions/<int:district_id>/concelhos/', get_concelhos_by_district, name='get_concelhos_by_district'),
    path('regions/<int:concelhos_id>/freguesias/', get_freguesias_by_concelho, name='get_freguesias_by_concelho'),
    re_path('empresa', empresa_view, name='empresa'),
    re_path('', views.home, name='home'),

    #re_path('api-auth/', include('rest_framework.urls')),
    #re_path('rest-auth/', include('rest_auth.urls')),
    #re_path('rest-auth/registration/', include('rest_auth.registration.urls')),
    #re_path('api/', include('users.urls', namespace='api')),

]


