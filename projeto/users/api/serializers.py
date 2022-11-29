from rest_framework import serializers
from users.models import User, Tourist, Seller

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=['username', 'email', 'is_tourist']

class TouristSignupSerializer(serializers.ModelSerializer):
    password = serializers.CharField(style={"input_type":"password"}, write_only = True)
    class Meta:
        model=User
        fields=['username', 'email', 'password']
        extra_kwargs={
            'password':{'write_only':True}
        }
    
    def save(self, **kwargs):
        user=User(
        username=self.validated_data['username'],
        email=self.validated_data['email']
        )
        password=self.validated_data['password']
        user.set_password(password)
        user.save()
        Tourist.objects.create(user)

        return user

class SellerSignupSerializer(serializers.ModelSerializer):
    password = serializers.CharField(style={"input_type":"password"}, write_only = True)
    class Meta:
        model=User
        fields=['username', 'email', 'password']
        extra_kwargs={
            'password':{'write_only':True}
        }

    def save(self, **kwargs):
        user=User(
        username=self.validated_data['username'],
        email=self.validated_data['email']
        )
        password=self.validated_data['password']
        user.set_password(password)
        user.save()
        Seller.objects.create(user)

        return user
