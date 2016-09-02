# Here we set the mime type so that the api can handle
# requests that conform to the jsonapi.org spec
# Thanks to: https://github.com/rails-api/active_model_serializers/issues/1027

api_mime_types = %w(
  application/vnd.api+json
  text/x-json
  application/json
)

Mime::Type.unregister :json
Mime::Type.register "application/json", :json, api_mime_types
