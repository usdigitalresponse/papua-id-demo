class VerifyIdentityWithAlloyJob < ApplicationJob
  queue_as :default

  def perform(applicant_id)
    return unless applicant = Applicant[applicant_id]
    if (verification = AlloyIdentityVerification.create(applicant: applicant, input: applicant.request_params)) #HACK move request_params elsewhere
      verification.initiate_verification
    end
  end
end
