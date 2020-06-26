"""
WSGI config for blood_finder_api project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.0/howto/deployment/wsgi/
"""

import os

from django.core.wsgi import get_wsgi_application

# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.development')
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.pythonanywhere')
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blood_finder_api.settings.heroku')

application = get_wsgi_application()
