"""
ASGI config for blood_finder_api project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/asgi/
"""

import os

from django.core.asgi import get_asgi_application

# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.development')
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.pythonanywhere')
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.heroku')

application = get_asgi_application()
