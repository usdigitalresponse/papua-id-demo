class ValidateIdentityWithAlloyJob < ApplicationJob
  queue_as :validations

  def perform(applicant_id)
    # Fetch the applicant:
    applicant = Applicant[applicant_id]
    validation = AlloyIdentityValidation.new(applicant: applicant, input: applicant.request_params) #HACK move request_params elsewhere

    # Step 3 - Run the verification:
    validation.output = Alloy::Api.evaluations(body: validation.input)
    validation.decision = :approved #HACK need to actually read this
    validation.status = :complete
    validation.save

    # TODO: Actually make decisions here:

    LineItemDecision.create(name: :first_name, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :last_name, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :birthdate, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :ssn, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :email_address, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :phone_number, decision: :approved, decidable: applicant)
    LineItemDecision.create(name: :address, decision: :approved, decidable: applicant)
  end
end
