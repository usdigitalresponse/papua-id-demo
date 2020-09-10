require 'truework'

$truework_enabled = false

if Rails.application.credentials.truework
	Truework.api_key = Rails.application.credentials.truework[:token]
	$truework_enabled = true
end
