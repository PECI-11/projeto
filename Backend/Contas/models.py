from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models
from django.core.validators import MinLengthValidator

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, password, **extra_fields)
    

class Tourist(AbstractBaseUser):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    last_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    date_of_birth = models.DateField()
    password = models.CharField(max_length=50, validators=[MinLengthValidator(8)])
    # add any other fields specific to tourists here

    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    USERNAME_FIELD = 'email'
    objects = CustomUserManager()

class CompanyManager(AbstractBaseUser):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    last_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    date_of_birth = models.DateField()
    password = models.CharField(max_length=50, validators=[MinLengthValidator(8)])
    events = models.TextField(blank=True)
    #regions = models.ManyToManyField('Region')
    nif = models.CharField(max_length=9, validators=[MinLengthValidator(9)])
    cae = models.CharField(max_length=5, validators=[MinLengthValidator(5)])
    address = models.TextField()
    phone_number = models.CharField(max_length=20, validators=[MinLengthValidator(2)])
    website = models.URLField(blank=True)

    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    objects = CustomUserManager()

class SystemAdmin(AbstractBaseUser):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    last_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    password = models.CharField(max_length=50, validators=[MinLengthValidator(8)])
    date_of_birth = models.DateField()
    # add any other fields specific to system admins here

    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    objects = CustomUserManager()

class EventsManager(AbstractBaseUser):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    last_name = models.CharField(max_length=50, validators=[MinLengthValidator(2)])
    password = models.CharField(max_length=50, validators=[MinLengthValidator(8)])
    date_of_birth = models.DateField()
    # add any other fields specific to events managers here

    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    objects = CustomUserManager()

# Create your models here.
