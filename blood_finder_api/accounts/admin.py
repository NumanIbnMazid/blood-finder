from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import UserProfile

UserAdmin.list_display += ('id', 'is_active',)


class UserProfileAdmin(admin.ModelAdmin):
    list_display = [
        '__str__', 'id', 'slug', 'gender', 'dob', 'blood_group', 'contact', 'updated_at'
    ]

    class Meta:
        model = UserProfile


admin.site.register(UserProfile, UserProfileAdmin)
