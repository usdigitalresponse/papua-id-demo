class Validation < ApplicationRecord
  self.abstract_class = true
  belongs_to :applicant
  has_many :line_item_decisions, dependent: :destroy

  enum status: { started: 0, in_process: 1, complete: 2, error: 3 }
  enum decision: { approved: 0, denied: 1 }

  # NOTE: Do not call `validate_applicant` in superclass.  Instead, call in subclass, like
  # TrueWorkIncomeValidation.validate_applicant
  def self.validate_applicant(applicant, input)
  	validation = self.new
  	validation.applicant = applicant
  	validation.input = input
  	validation.status = :started
  	validation.save!
  	self.job_class.set(wait: 1.second).perform_later(validation.id)

  	validation
  end
end
