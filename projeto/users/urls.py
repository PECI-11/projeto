from django.urls import path
from users.views import TouristRegistrationView, SellerRegistrationView

app_name = 'core'

urlpatterns = [
    #Registration Urls
    path('registration/tourist/', TouristRegistrationView.as_view(), name='register-tourist'),
    path('registration/seller/', SellerRegistrationView.as_view(), name='register-seller'),
    
]