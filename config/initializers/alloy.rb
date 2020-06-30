require 'alloy-api'

# Main workflow:
Alloy::Api.api_uri    = Rails.application.credentials.alloy[:uri]
Alloy::Api.api_token  = Rails.application.credentials.alloy[:token]
Alloy::Api.api_secret = Rails.application.credentials.alloy[:secret]

# Documents workflow:
Alloy::Api.set_endpoint(
  :documents,
  Rails.application.credentials.alloy[:document_token],
  Rails.application.credentials.alloy[:document_secret],
  Rails.application.credentials.alloy[:uri]
)

SHOWN_TAGS = ['Fraud Risk', 'SSN Warning', 'SSN Not Verified']
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
    'SSN Not Verified'
  ],
  danger: [
    'Device Warning',
    'Address Warning',
    'Email Warning',
    'Fraud Warning',
    'Fraud Risk'
  ]
}
