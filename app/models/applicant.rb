class Applicant < ApplicationRecord
  validates :first_name, :last_name, :ssn, :birthdate, presence: true
  has_one :bank_account

  enum descision: {
    Approved: 1,
    "Manual Review": 0,
    Denied: -1
  }

  scope :for_current_workflow, -> { where(application_token: Rails.application.credentials.alloy[:token]) }

  def ssn=(value)
    super(value.to_s.gsub(/-/, ''))
  end

  def entity_info
    Alloy::Api.entity_details(entity_id)
  end

  def evaluation_info
    Alloy::Api.evaluation_details(entity_id, evaluation_id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def alloy_app_uri
    "https://app.alloy.co/entities/#{entity_id}/evaluations/#{evaluation_id}/"
  end

  def tags
    descision_response["summary"]["tags"]
  end

  def make_decision
    # This probably belongs somewhere else, but for right now, it's here.
    request_params = {
      name_first: first_name,
      name_last: last_name,
      birth_date: birthdate.iso8601,
      email_address: email_address,
      phone_number: phone_number,
      address_line_1: street_address,
      address_city: city,
      address_state: state,
      address_postal_code: postal_code,
      address_country_code: 'US',
      document_ssn: ssn,
      'meta.case_number': case_number
    }

    self.descision_response = Alloy::Api.evaluations(body: request_params)
    self.descision = descision_response['summary']['outcome']
    self.entity_id = descision_response['entity_token']
    self.evaluation_id = descision_response['evaluation_token']
    self.application_token = descision_response['application_token']
    self.application_version_id = descision_response['application_version_id']

    self.save
  end
end
