class ValidateIdentityWithAlloyJob < ApplicationJob
  queue_as :validations

  def perform(applicant_id)
    return unless applicant = Applicant[applicant_id]
    if (validation = AlloyIdentityValidation.create(applicant: applicant, input: applicant.request_params)) #HACK move request_params elsewhere
      validation.initiate_validation
    end
  end
end
