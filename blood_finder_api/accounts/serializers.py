from rest_framework import serializers
from rest_auth.serializers import UserDetailsSerializer
from .models import UserProfile
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator
from rest_auth.serializers import TokenSerializer
from django.contrib.auth import get_user_model
from rest_auth.registration.serializers import RegisterSerializer
from .choices import BLOOD_GROUP_CHOICES
from .utils import ChoicesField


class UserSerializer(UserDetailsSerializer):

    profile_id = serializers.IntegerField(source="profile.id")
    slug = serializers.CharField(source="profile.slug")
    gender = serializers.CharField(source="profile.gender")
    dob = serializers.DateField(source="profile.dob")
    blood_group = serializers.CharField(source="profile.blood_group")
    contact = serializers.CharField(source="profile.contact")
    address = serializers.CharField(source="profile.address")
    city = serializers.CharField(source="profile.city")
    state = serializers.CharField(source="profile.state")
    country = serializers.CharField(source="profile.country")
    about = serializers.CharField(source="profile.about")
    created_at = serializers.DateTimeField(source="profile.created_at")
    updated_at = serializers.DateTimeField(source="profile.updated_at")

    class Meta(UserDetailsSerializer.Meta):
        Model = User
        fields = UserDetailsSerializer.Meta.fields + (
            'profile_id', 'slug', 'gender', 'dob', 'blood_group', 'contact', 'address', 'city', 'state', 'country', 'about', 'created_at', 'updated_at'
        )

        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    def update(self, instance, validated_data):
        profile_data = validated_data.pop('profile', {})
        profile_id = profile_data.get('id')
        slug = profile_data.get('slug')
        gender = profile_data.get('gender')
        dob = profile_data.get('dob')
        blood_group = profile_data.get('blood_group')
        contact = profile_data.get('contact')
        address = profile_data.get('address')
        city = profile_data.get('city')
        state = profile_data.get('state')
        country = profile_data.get('country')
        about = profile_data.get('about')
        created_at = profile_data.get('created_at')
        updated_at = profile_data.get('updated_at')

        instance = super(UserSerializer, self).update(instance, validated_data)

        # get and update user profile
        profile = instance.profile
        if profile_data and profile_id:
            profile.id = profile_id
        if profile_data and slug:
            profile.slug = slug
        if profile_data and gender:
            profile.gender = gender
        if profile_data and dob:
            profile.dob = dob
        if profile_data and blood_group:
            profile.blood_group = blood_group
        if profile_data and contact:
            profile.contact = contact
        if profile_data and address:
            profile.address = address
        if profile_data and city:
            profile.city = city
        if profile_data and state:
            profile.state = state
        if profile_data and country:
            profile.country = country
        if profile_data and about:
            profile.about = about
        if profile_data and created_at:
            profile.created_at = created_at
        if profile_data and updated_at:
            profile.updated_at = updated_at

        # Saving profile instance
        profile.save()
        return instance


class CoreUserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = (
            'id', 'username', 'email', 'first_name', 'last_name', 'date_joined', 'is_active'
        )


# class UserProfileSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = UserProfile
#         fields = (
#             'slug', 'gender', 'dob', 'blood_group', 'contact', 'address',
#             'city', 'state', 'country', 'about', 'created_at', 'updated_at'
#         )

# class UserTokenSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = get_user_model()
#         fields = ('id', 'profile')
#         # fields = "__all__"

class UserProfileTokenSerializer(UserDetailsSerializer):

    profile_id = serializers.IntegerField(source="profile.id")
    profile_slug = serializers.CharField(source="profile.slug")

    class Meta(UserDetailsSerializer.Meta):
        Model = User
        fields = ('id', 'profile_id', 'profile_slug')
        # fields = UserDetailsSerializer.Meta.fields + (
        #     'profile_id', 'slug',
        # )


class CustomTokenSerializer(TokenSerializer):
    user = UserProfileTokenSerializer(read_only=True)

    class Meta(TokenSerializer.Meta):
        fields = ('key', 'user')


class UserProfileSerializer(serializers.ModelSerializer):
    user__id = serializers.IntegerField(source="user.id")
    user__username = serializers.CharField(source="user.username")
    user__email = serializers.CharField(source="user.email")
    user__password = serializers.CharField(source="user.password")
    user__first_name = serializers.CharField(source="user.first_name")
    user__last_name = serializers.CharField(source="user.last_name")
    user__date_joined = serializers.DateTimeField(source="user.date_joined")
    user__is_staff = serializers.BooleanField(source="user.is_staff")
    user__is_active = serializers.BooleanField(source="user.is_active")
    user__is_superuser = serializers.BooleanField(source="user.is_superuser")
    user__last_login = serializers.DateTimeField(source="user.last_login")
    # Class Methods
    get_dynamic_name = serializers.DateTimeField("get_dynamic_name")

    class Meta:
        model = UserProfile
        # fields = '__all__'
        fields = [
            'user__id', 'user__username', 'user__email', 'user__password', 'user__first_name', 'user__last_name', 'user__date_joined', 'user__is_staff', 'user__is_active', 'user__is_superuser', 'user__last_login',
            'id', 'slug', 'gender', 'dob', 'blood_group', 'contact', 'address', 'city', 'state', 'country', 'about', 'created_at', 'updated_at',
            'get_dynamic_name'
        ]


class CustomRegisterSerializer(RegisterSerializer):
    # blood_group = ChoicesField(
    #     choices=BLOOD_GROUP_CHOICES, required=True
    # )
    blood_group = serializers.ChoiceField(
        choices=[
            'A_POSITIVE', 'A_NEGATIVE', 'B_POSITIVE', 'B_NEGATIVE',
            'O_POSITIVE', 'O_NEGATIVE', 'AB_POSITIVE', 'AB_NEGATIVE',
        ],
    )

    def get_cleaned_data(self):
        data_dict = super().get_cleaned_data()
        data_dict['blood_group'] = self.validated_data.get(
            'blood_group', '')
        return data_dict
