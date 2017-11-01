from backend.settings import *

DEBUG = True

INTERNAL_IPS = ['127.0.0.1']
ALLOWED_HOSTS += INTERNAL_IPS
ALLOWED_HOSTS.append('localhost')
ALLOWED_HOSTS.append('localhost:4000')
ALLOWED_HOSTS.append('127.0.0.1:4000')

#INSTALLED_APPS.append('debug_toolbar')

# cross origin
INSTALLED_APPS.append('corsheaders')
MIDDLEWARE += ['corsheaders.middleware.CorsMiddleware',
               'django.middleware.common.CommonMiddleware',
               'backend.disable.DisableCSRF',]

SESSION_COOKIE_DOMAIN = '127.0.0.1'
CORS_ALLOW_CREDENTIALS = True
CORS_ORIGIN_ALLOW_ALL = True   

CORS_ORIGIN_WHITELIST = ALLOWED_HOSTS
CSRF_TRUSTED_ORIGINS = ALLOWED_HOSTS

MIDDLEWARE.remove('django.middleware.csrf.CsrfViewMiddleware')
#MIDDLEWARE.remove('django.middleware.csrf.CsrfResponseMiddleware')
