import logging
import re
import json
from django.http import JsonResponse


logger = logging.getLogger('core')


def camel_to_snake(name):
    # Insert underscore between lowercase/digit and uppercase
    name = re.sub(r'(?<=[a-z0-9])([A-Z])', r'_\1', name)
    # Insert underscore between letters and digits (both ways)
    name = re.sub(r'(?<=[a-zA-Z])(?=[0-9])', '_', name)
    name = re.sub(r'(?<=[0-9])(?=[a-zA-Z])', '_', name)
    return name.lower()


def snake_to_camel(name):
    parts = name.split('_')
    return parts[0] + ''.join(
        part if part.isdigit() else part.title() for part in parts[1:]
    )


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
            and request.body
        ):
            try:
                body_unicode = request.body.decode('utf-8')
                data = json.loads(body_unicode)
                converted_data = convert_keys_to_snake_case(data)
                request._body = json.dumps(converted_data).encode('utf-8')
                print("converted == ", converted_data)
            except json.JSONDecodeError:
                return JsonResponse({'error': 'Invalid JSON'}, status=400)

        response = self.get_response(request)

        try:
            if hasattr(response, 'content') and response.get('Content-Type') == 'application/json':
                content = response.content.decode('utf-8')
                data = json.loads(content)
                converted = convert_keys_to_camel_case(data)
                new_content = json.dumps(converted).encode('utf-8')
                response.content = new_content
                response['Content-Length'] = str(len(new_content))  # ✅ FIX HERE
                logger.info(f"Response from {request.path}: {new_content}")

        except Exception as e:
            pass  # Fail-safe

        return response
