from django.shortcuts import render
from rest_auth.registration.views import RegisterView
from users.serializers import (
    TouristCustomRegistrationSerializer, SellerCustomRegistrationSerializer
    )

class TouristRegistrationView(RegisterView):
    serializer_class = TouristCustomRegistrationSerializer


class SellerRegistrationView(RegisterView):
    serializer_class = SellerCustomRegistrationSerializer
