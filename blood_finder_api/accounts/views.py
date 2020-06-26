from django.shortcuts import get_object_or_404, render
from rest_framework import viewsets
from rest_framework.generics import (
    ListCreateAPIView, RetrieveUpdateDestroyAPIView,
)
from .models import UserProfile
from django.contrib.auth.models import User
from .serializers import (
    CoreUserSerializer, UserSerializer, UserProfileSerializer
)
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import Http404
from rest_framework.permissions import (
    AllowAny, IsAdminUser, IsAuthenticated, Http404, IsAuthenticatedOrReadOnly
)
from rest_framework.authentication import (
    TokenAuthentication, SessionAuthentication, BasicAuthentication, BaseAuthentication, CsrfViewMiddleware, CSRFCheck, RemoteUserAuthentication
)
from .permissions import (IsOwnerProfileOrReadOnly)



# class UserViewSet(viewsets.ModelViewSet):
#     queryset = User.objects.all()
#     serializer_class = CoreUserSerializer


class UserList(APIView):
    """
    List all users, or create a new snippet.
    """
    # authentication_classes = [SessionAuthentication, BasicAuthentication]
    authentication_classes = [TokenAuthentication,]
    permission_classes = (AllowAny,)
    # permission_classes = (IsAuthenticated,)

    def get(self, request, format=None):
        users = User.objects.all()
        serializer = CoreUserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = CoreUserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# class UserProfileViewSet(viewsets.ModelViewSet):
#     queryset = UserProfile.objects.all()
#     serializer_class = UserProfileSerializer

#     def get_queryset(self):
#         if self.action == 'list':
#             return self.queryset.filter(user=self.request.user)
#         return self.queryset


class UserProfileViewSet(RetrieveUpdateDestroyAPIView):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer
    # permission_classes = [IsOwnerProfileOrReadOnly, IsAuthenticated,]
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsOwnerProfileOrReadOnly, ]
    # permission_classes = (AllowAny,)

    def get_object(self):
        slug = self.kwargs['slug']
        # slug = self.request.user.profile.slug
        obj = get_object_or_404(UserProfile, slug=slug)
        return obj



