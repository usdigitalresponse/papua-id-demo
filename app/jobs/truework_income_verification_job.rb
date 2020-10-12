class TrueworkIncomeVerificationJob < ApplicationJob
  queue_as :default

  def perform(verification_id)
    verification = TrueworkIncomeVerification.find(verification_id)
    if verification.status == "started"
        verification.initiate_verification
    elsif verification.status == "in_process"
        verification.poll_verification
    else
        raise "Error: TrueworkIncomeVerificationJob.perform called on verification in state #{verification.status}"
    end
  end
end
