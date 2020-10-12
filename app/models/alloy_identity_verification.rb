require 'base64'

class AlloyIdentityVerification < IdentityVerification
  def initiate_verification
    self.output = Alloy::Api.evaluations(body: self.input)
    make_decision
    self.status = :complete
    save
  end

  protected

  def make_decision
    # TODO: Actually make decisions here:

    LineItemDecision.create(name: :first_name, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :last_name, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :birthdate, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :ssn, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :email_address, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :phone_number, decision: :approved, decidable: applicant, verification: self)
    LineItemDecision.create(name: :address, decision: :approved, decidable: applicant, verification: self)
  end
end
