from rest_framework import serializers
from users.models import User, Tourist, Seller
from rest_auth.registration.serializers import RegisterSerializer
from rest_framework.authtoken.models import Token

class TouristCustomRegistrationSerializer(RegisterSerializer):
    tourist = serializers.PrimaryKeyRelatedField(read_only=True,) 
    phone = serializers.CharField(required=True)
    
    def get_cleaned_data(self):
            data = super(TouristCustomRegistrationSerializer, self).get_cleaned_data()
            extra_data = {
                'phone' : self.validated_data.get('phone', ''),
            }
            data.update(extra_data)
            return data

    def save(self, request):
        user = super(TouristCustomRegistrationSerializer, self).save(request)
        user.is_tourist = True
        user.save()
        tourist = Tourist(tourist=user, phone=self.cleaned_data.get('phone'))
        tourist.save()
        return user


class SellerCustomRegistrationSerializer(RegisterSerializer):
    Region = [
        ("Regiao Norte", "Regiao Norte"),
        ("Regiao Centro", "Regiao Centro"),
        ("Regiao Sul","Regiao Sul"),
        ("Açores","Açores"),
        ("Madeira","Madeira"),
    ]

    seller = serializers.PrimaryKeyRelatedField(read_only=True,) 
    address = serializers.CharField(required=True)
    nif = serializers.CharField(required=True)
    cae = serializers.CharField(required=True)
    phone = serializers.CharField(required=True)
    email = serializers.CharField(required=True)
    region = serializers.ChoiceField(choices = Region)
    website = serializers.CharField(required=True)
    
    def get_cleaned_data(self):
            data = super(SellerCustomRegistrationSerializer, self).get_cleaned_data()
            extra_data = {
                'address' : self.validated_data.get('address', ''),
                'nif' : self.validated_data.get('nif', ''),
                'cae' : self.validated_data.get('cae', ''),
                'phone' : self.validated_data.get('phone', ''),
                'email' : self.validated_data.get('email', ''),
                'region' : self.validated_data.get('region', ''),
                'website' : self.validated_data.get('website', ''),
            }
            data.update(extra_data)
            return data

    def save(self, request):
        user = super(SellerCustomRegistrationSerializer, self).save(request)
        user.is_seller = True
        user.save()
        seller = Seller(seller=user, address=self.cleaned_data.get('address'), 
                nif=self.cleaned_data.get('nif'),
                cae=self.cleaned_data.get('cae'),
                phone=self.cleaned_data.get('phone'),
                email=self.cleaned_data.get('email'),
                region=self.cleaned_data.get('region'),
                website=self.cleaned_data.get('website'),)
        seller.save()
        return user