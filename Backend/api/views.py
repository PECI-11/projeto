from django.shortcuts import render
from rest_framework import generics
from .models import Accommodation, Restaurant
from .serializers import AccommodationSerializer, RestaurantSerializer

class AccommodationList(generics.ListAPIView):
    queryset = Accommodation.objects.all()
    serializer_class = AccommodationSerializer

class RestaurantList(generics.ListAPIView):
    queryset = Restaurant.objects.all()
    serializer_class = RestaurantSerializer
# Create your views here.

