from rest_framework import serializers
from Contas.models import *


class TouristSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tourist
        fields = ('id', 'email', 'first_name', 'last_name', 'date_of_birth')

class CompanyManagerSerializer(serializers.ModelSerializer):
    class Meta:
        model = CompanyManager
        fields = ('id', 'email', 'first_name', 'last_name', 'date_of_birth', 'events', 'nif', 'cae', 'address', 'phone_number', 'website')

class SystemAdminSerializer(serializers.ModelSerializer):
    class Meta:
        model = SystemAdmin
        fields = ('id', 'email', 'first_name', 'last_name', 'date_of_birth')

class EventsManagerSerializer(serializers.ModelSerializer):
    class Meta:
        model = EventsManager
        fields = ('id', 'email', 'first_name', 'last_name', 'date_of_birth')
