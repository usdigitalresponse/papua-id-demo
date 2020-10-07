class Verification < ApplicationRecord
  belongs_to :applicant # NOT optional, keep verification.
  has_many :line_item_decisions, dependent: :destroy

  enum status: { started: 0, in_process: 1, complete: 2, error: 3 }
  enum decision: { approved: 0, denied: 1 }

  # NOTE: Do not call `verify_applicant` in superclass.  Instead, call in subclass, like
  # TrueworkIncomeVerification.verify_applicant
  def self.verify_applicant(applicant, input)
  	verification = self.new
  	verification.applicant = applicant
  	verification.input = input
  	verification.status = :started
  	verification.save!
  	self.job_class.set(wait: 1.second).perform_later(verification.id)

  	verification
  end
end
