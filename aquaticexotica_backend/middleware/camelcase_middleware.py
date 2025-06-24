import re
import json
from django.http import JsonResponse


def camel_to_snake(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()


def snake_to_camel(name):
    parts = name.split('_')
    return parts[0] + ''.join(word.title() for word in parts[1:])


def convert_keys_to_snake_case(data):
    if isinstance(data, dict):
        return {camel_to_snake(k): convert_keys_to_snake_case(v) for k, v in data.items()}
    elif isinstance(data, list):
        return [convert_keys_to_snake_case(item) for item in data]
    return data


def convert_keys_to_camel_case(data):
    if isinstance(data, dict):
        return {snake_to_camel(k): convert_keys_to_camel_case(v) for k, v in data.items()}
    elif isinstance(data, list):
        return [convert_keys_to_camel_case(item) for item in data]
    return data


class CamelSnakeCaseMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # 🐍 Convert request keys: camelCase → snake_case
        if (
            request.content_type == 'application/json'
            and request.method in ['POST', 'PUT', 'PATCH']
            and request.body
        ):
            try:
                body_unicode = request.body.decode('utf-8')
                data = json.loads(body_unicode)
                converted_data = convert_keys_to_snake_case(data)
                request._body = json.dumps(converted_data).encode('utf-8')
            except json.JSONDecodeError:
                return JsonResponse({'error': 'Invalid JSON'}, status=400)

        # Process the view
        response = self.get_response(request)

        # 🐫 Convert response keys: snake_case → camelCase
        if isinstance(response, JsonResponse):
            try:
                if hasattr(response, 'content') and response['Content-Type'] == 'application/json':
                    data = json.loads(response.content)
                    converted = convert_keys_to_camel_case(data)
                    response.content = json.dumps(converted).encode('utf-8')
            except Exception:
                pass  # Avoid breaking the app due to transformation issues

        return response
