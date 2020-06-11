require 'alloy-api'

Alloy::Api.api_uri    = Rails.application.credentials.alloy[:uri]
Alloy::Api.api_token  = Rails.application.credentials.alloy[:token]
Alloy::Api.api_secret = Rails.application.credentials.alloy[:secret]

SHOWN_TAGS = ['Fraud Risk', 'SSN Warning']
TAG_GROUPS = {
  success: [
    "KYC Address Match",
    "KYC DOB Match",
    "KYC Name Match",
    "KYC SSN Match",
    "Phone Match"
  ],
  warning: [
    'SSN Warning',
    'SSN Miskey',
    'DOB Miskey',
    'Foreign Device',
    'Fraud Risk'
  ],
  danger: [
    'Device Warning',
    'Address Warning',
    'Email Warning',
    'Fraud Warning'
  ]
}
