from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models.signals import post_save
from django.conf import settings
from django.dispatch import receiver
from rest_framework import serializers
from rest_framework.authtoken.models import Token

# Create your models here.

class User(AbstractUser):
    is_admin = models.BooleanField('is admin', default=False)
    is_tourist = models.BooleanField('is tourist', default=False)
    is_seller = models.BooleanField('is seller', default=False)

    def __str__(self):
        return self.username

@receiver(post_save, sender = settings.AUTH_USER_MODEL)
def auth_token(sender, instance=None, created=False, **k):
    if created:
        Token.objects.create(user=instance)


    
class Tourist(models.Model):
    user=models.OneToOneField(User, related_name="tourist", on_delete=models.CASCADE)
    phone = models.CharField(max_length=9)

    def __str__(self):
        return self.user.username

class Seller(models.Model):
    Region = [
        ("Regiao Norte", "Regiao Norte"),
        ("Regiao Centro", "Regiao Centro"),
        ("Regiao Sul","Regiao Sul"),
        ("Açores","Açores"),
        ("Madeira","Madeira"),
    ]

    company = models.OneToOneField(User, related_name="seller", on_delete=models.CASCADE)
    address = models.TextField(default="")
    nif = models.CharField(max_length=9,default="")
    cae = models.CharField(max_length=5,default="")
    phone = models.CharField(max_length=9,default="")
    email = models.CharField(max_length=100,default="")
    region = models.CharField(max_length = 13, choices = Region, default="Regiao Norte")
    website = models.CharField(max_length=100,default="")


    def __str__(self):
        return self.company
