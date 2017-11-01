
from django.conf import settings
from django.conf.urls import url, include

urlpatterns = [

]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns.append(url(r'^__debug__/', include(debug_toolbar.urls)))
