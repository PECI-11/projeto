from django.urls import path
from .views import TouristSignupSerializer, SellerSignupSerializer, TouristSignupView, SellerSignupView


urlpatterns=[
    path('signup/tourist/', TouristSignupView.as_view()),
    path('signup/seller/', SellerSignupView.as_view())
]