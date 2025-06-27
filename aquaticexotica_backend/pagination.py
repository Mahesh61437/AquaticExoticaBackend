# pagination.py
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response


class FlatPageNumberPagination(PageNumberPagination):
    page_size = 10  # or whatever you want

    def get_paginated_response(self, data):
        # Just return the list of paginated items, drop meta info
        return Response(data)
