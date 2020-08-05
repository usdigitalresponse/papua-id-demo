class Applicant < ApplicationRecord
  has_many :documents
  has_one :bank_account
  has_one :wage_verification

  enum descision: {
    Approved: 1,
    "Manual Review": 0,
    Denied: -1,
    unprocessed: -2
  }

  enum processing_status: {
    unable_to_process: -1,
    queued: 0,
    processed: 1
  }

  after_create_commit :make_descision

  scope :for_current_workflow, -> { where(application_token: Rails.application.credentials.alloy[:token]) }

  validates :first_name, :last_name, :ssn, :birthdate, presence: true
  
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:first_name, :last_name]

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

  def request_params
    {
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
  end

  protected

  def make_descision
    ValidateApplicantJob.set(wait: 1.second).perform_later(self.id)
  end
end
