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

    # def clean_username(self):
    #     username = self.cleaned_data['username']

    #     try:
    #         user = User.objects.get(username=username)
    #     except user.DoesNotExist:
    #         return username
    #     raise serializers.ValidationError(u'Username "%s" is already in use.' % username)

    def save(self, request):
        user = super(TouristCustomRegistrationSerializer, self).save(request)
        user.is_tourist = True
        user.save()
        tourist = Tourist(tourist=user, phone=self.cleaned_data.get('phone'))
        tourist.save()
        return user



# class SellerCustomRegistrationSerializer(RegisterSerializer):
#     Region = [
#         ("Regiao Norte", "Regiao Norte"),
#         ("Regiao Centro", "Regiao Centro"),
#         ("Regiao Sul","Regiao Sul"),
#         ("Açores","Açores"),
#         ("Madeira","Madeira"),
#     ]

#     seller = serializers.PrimaryKeyRelatedField(read_only=True) 
#     address = serializers.CharField(required=True)
#     nif = serializers.CharField(required=True)
#     cae = serializers.CharField(required=True)
#     phone = serializers.CharField(required=True)
#     email = serializers.CharField(required=True)
#     region = serializers.ChoiceField(choices = Region)
#     website = serializers.URLField(required=True)
    
#     def get_cleaned_data(self):
#             data = super(SellerCustomRegistrationSerializer, self).get_cleaned_data()
#             extra_data = {
#                 'address' : self.validated_data.get('address', ''),
#                 'nif' : self.validated_data.get('nif', ''),
#                 'cae' : self.validated_data.get('cae', ''),
#                 'phone' : self.validated_data.get('phone', ''),
#                 'email' : self.validated_data.get('email', ''),
#                 'region' : self.validated_data.get('region', ''),
#                 'website' : self.validated_data.get('website', ''),
#             }
#             data.update(extra_data)
#             return data

#     def save(self, request):
#         user = super(SellerCustomRegistrationSerializer, self).save(request)
#         user.is_seller = True
#         user.save()
#         seller = Seller(seller=user, address=self.cleaned_data.get('address'), 
#                 nif=self.cleaned_data.get('nif'),
#                 cae=self.cleaned_data.get('cae'),
#                 phone=self.cleaned_data.get('phone'),
#                 email=self.cleaned_data.get('email'),
#                 region=self.cleaned_data.get('region'),
#                 website=self.cleaned_data.get('website'),)
#         seller.save()
#         return user


class SellerCustomRegistrationSerializer(RegisterSerializer):
    # define regions as a tuple of tuples
    REGIOES = (
        ("Regiao Norte", (
            ("Braga", "Braga"),
            ("Porto", "Porto"),
            ("Viana do Castelo", "Viana do Castelo"),
            ("Vila Real", "Vila Real"),
            ("Bragança", "Bragança")
        )),
        ("Regiao Centro", (
            ("Aveiro", "Aveiro"),
            ("Viseu", "Guarda"),
            ("Coimbra", "Coimbra"),
            ("Castelo Branco", "Castelo Branco"),
            ("Leiria", "Leiria"),
            ("Santarem", "Santarem"),
            ("Portalegre", "Portalegre"),
        )),
        ("Regiao Sul", (
            ("Faro", "Faro"),
            ("Setubal", "Setubal"),
            ("Évora", "Évora"),
            ("Lisboa", "Lisboa"),
            ("Beja", "Beja"),
        )),
        ("Açores", (
            ("Angra do Heroismo", "Angra do Heroismo"),
            ("Horta", "Horta"),
            ("Ponta Delgada", "Ponta Delgada"),
            ("Corvo", "Corvo"),
            ("Flores", "Flores"),
            ("São Jorge", "São Jorge"),
            ("Faial", "Faial"),
            ("Terceira", "Terceira"),   
            ("São Miguel", "São Miguel"),
        )),
        ("Madeira", (
            ("Funchal", "Funchal"),
            ("Porto Santo", "Porto Santo"),
        )),
    )

    seller = serializers.PrimaryKeyRelatedField(read_only=True)
    address = serializers.CharField(required=True)
    nif = serializers.CharField(required=True)
    cae = serializers.CharField(required=True)
    phone = serializers.CharField(required=True)
    email = serializers.CharField(required=True)
    region = serializers.ChoiceField(choices=REGIOES)
    municipio = serializers.CharField(required=True)
    website = serializers.URLField(required=True)

    def get_cleaned_data(self):
        data = super(SellerCustomRegistrationSerializer, self).get_cleaned_data()
        extra_data = {
            'address': self.validated_data.get('address', ''),
            'nif': self.validated_data.get('nif', ''),
            'cae': self.validated_data.get('cae', ''),
            'phone': self.validated_data.get('phone', ''),
            'email': self.validated_data.get('email', ''),
            'region': self.validated_data.get('region', ''),
            'municipio': self.validated_data.get('municipio', ''),
            'website': self.validated_data.get('website', ''),
        }
        data.update(extra_data)
        return data

    def save(self, request):
        user = super(SellerCustomRegistrationSerializer, self).save(request)
        user.is_seller = True
        user.save()
        seller = Seller(
            seller=user,
            address=self.cleaned_data.get('address'),
            nif=self.cleaned_data.get('nif'),
            cae=self.cleaned_data.get('cae'),
            phone=self.cleaned_data.get('phone'),
            email=self.cleaned_data.get('email'),
            region=self.cleaned_data.get('region'),
            municipio=self.cleaned_data.get('municipio'),
            website=self.cleaned_data.get('website'),
        )
        seller.save()
        return user
