require 'alloy-api'

Alloy::Api.api_uri    = Rails.application.credentials.alloy[:uri]
Alloy::Api.api_token  = Rails.application.credentials.alloy[:token]
Alloy::Api.api_secret = Rails.application.credentials.alloy[:secret]
