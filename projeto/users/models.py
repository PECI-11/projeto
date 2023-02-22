from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models.signals import post_save
from django.conf import settings
from django.dispatch import receiver
from rest_framework import serializers
from rest_framework.authtoken.models import Token
from django.core.validators import MinLengthValidator, EmailValidator

# Create your models here.

class User(AbstractUser):
    is_tourist = models.BooleanField(default=False)
    is_seller = models.BooleanField(default=False)

    def __str__(self):
        return self.username 

# @receiver(post_save, sender = settings.AUTH_USER_MODEL)
# def auth_token(sender, instance=None, created=False, **kwargs):
#     if created:
#         Token.objects.create(user=instance)
    
class Tourist(models.Model):
    tourist=models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, blank=True, null=True)
    phone = models.CharField(max_length=9, default='nothing')

    def __str__(self):
        return self.tourist.username

class Seller(models.Model):
    Region = [
        ("Regiao Norte", "Regiao Norte"),
        ("Regiao Centro", "Regiao Centro"),
        ("Regiao Sul","Regiao Sul"),
        ("Açores","Açores"),
        ("Madeira","Madeira"),
    ]

    seller = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    address = models.TextField(default='nothing')
    nif = models.CharField(max_length=9,validators=[MinLengthValidator(9)],default="nothing")
    cae = models.CharField(max_length=5,validators=[MinLengthValidator(5)],default="nothing")
    phone = models.CharField(max_length=9,validators=[MinLengthValidator(9)],default="nothing") 
    email = models.CharField(max_length=100,validators=[EmailValidator()],default="nothing") #devia estar a funcionar
    region = models.CharField(max_length = 13, choices = Region, default="Regiao Norte")
    website = models.URLField(max_length=100,default="nothing")


    def __str__(self):
        return self.seller.username
