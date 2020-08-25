class ValidateApplicantJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    applicant = Applicant.find(document_id)

    # Step 3 - Run the verification:
    request_params = applicant.request_params
    applicant.descision_response = Alloy::Api.evaluations(body: request_params)
    applicant.descision = applicant.descision_response['summary']['outcome']
    applicant.entity_id = applicant.descision_response['entity_token']
    applicant.evaluation_id = applicant.descision_response['evaluation_token']
    applicant.application_token = applicant.descision_response['application_token']
    applicant.application_version_id = applicant.descision_response['application_version_id']
    applicant.processing_status = :processed

    applicant.save

    LineItemDecision.create(name: :first_name, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :last_name, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :birthdate, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :ssn, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :email_address, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :phone_number, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :address, decision: :approved, decidable: applicant)
  end
end
