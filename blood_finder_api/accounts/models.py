from django.db import models
from django.conf import settings
from django.db.models.signals import post_save, pre_save
from django.dispatch import receiver
from .choices import GENDER_CHOICES, BLOOD_GROUP_CHOICES
from util.utils import random_time_str
from rest_framework.authtoken.models import Token
from middlewares.middlewares import RequestMiddleware

# Create your models here.


class UserProfile(models.Model):

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, unique=True, related_name='profile', verbose_name='user'
    )
    slug = models.SlugField(
        unique=True, verbose_name='slug'
    )
    gender = models.CharField(
        choices=GENDER_CHOICES, blank=True, null=True, max_length=10, verbose_name='gender'
    )
    dob = models.DateField(
        blank=True, null=True, verbose_name='DOB'
    )
    blood_group = models.CharField(
        max_length=10, blank=True, null=True, choices=BLOOD_GROUP_CHOICES, verbose_name='blood group'
    )
    contact = models.CharField(
        max_length=20, blank=True, null=True, verbose_name='contact'
    )
    address = models.TextField(
        max_length=200, blank=True, null=True, verbose_name='address'
    )
    city = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='city'
    )
    state = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='state/province'
    )
    country = models.CharField(
        blank=True, null=True, max_length=100, verbose_name='country'
    )
    about = models.TextField(
        max_length=300, blank=True, null=True, verbose_name='about'
    )
    created_at = models.DateTimeField(
        auto_now_add=True, verbose_name='created at'
    )
    updated_at = models.DateTimeField(
        auto_now=True, verbose_name='updated at'
    )

    class Meta:
        verbose_name = ("User Profile")
        verbose_name_plural = ("User Profiles")
        ordering = ["-user__date_joined"]

    def username(self):
        return self.user.username

    def get_username(self):
        if self.user.first_name or self.user.last_name:
            name = self.user.get_full_name()
        else:
            name = self.user.username
        return name

    def get_smallname(self):
        if self.user.first_name or self.user.last_name:
            name = self.user.get_short_name()
        else:
            name = self.user.username
        return name

    def get_dynamic_name(self):
        if len(self.get_username()) < 13:
            name = self.get_username()
        else:
            name = self.get_smallname()
        return name

    def __str__(self):
        return self.user.username


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    username = instance.username.lower()
    slug_binding = username+'-'+random_time_str()
    try:
        request = RequestMiddleware(get_response=None)
        request = request.thread_local.current_request
        blood_group = request.POST.get("blood_group")
        # print(blood_group)
        if created:
            UserProfile.objects.create(
                user=instance, blood_group=blood_group, slug=slug_binding
            )
            # UserProfile.objects.create(
            #     user=instance, slug=slug_binding
            # )
            Token.objects.create(user=instance)
    except AttributeError:
        if created:
            UserProfile.objects.create(
                user=instance, slug=slug_binding
            )
    instance.profile.save()
