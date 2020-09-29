class Applicant < ApplicationRecord
  has_many :documents, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  has_one :wage_verification, dependent: :destroy
  has_many :line_item_decisions, as: :decidable, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :validations, dependent: :destroy

  attr_accessor :disable_verification

  enum decision: {
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

  enum status: {
    filed: 1,
    verified: 2,
    review: 3,
    closed: 4
  }

  audited on: [:update]

  after_create_commit :make_decision, unless: -> { disable_verification }

  scope :for_current_workflow, -> { where(application_token: Rails.application.credentials.alloy[:token]) }

  validates :first_name, :last_name, :ssn, :birthdate, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:id, :first_name, :last_name, :ssn, :birthdate]

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
    decision_response["summary"]["tags"]
  end

  def address(format = :one_line)
    case format
    when :one_line
      "#{street_address}, #{city}, #{state}, #{postal_code}"
    end
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

  def status_number
     Applicant.statuses[status]
  end

  protected

  def make_decision
    #ValidateApplicantJob.set(wait: 1.second).perform_later(self.id)
  end
end
