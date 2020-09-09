class Validation < ApplicationRecord
  belongs_to :applicant

  enum status: [ :started, :in_process, :complete, :error ]
  enum decision: [ :approved, :denied]

  # NOTE: Do not call `validate_applicant` in superclass.  Instead, call in subclass, like
  # TrueWorkWageValidation.validate_applicant
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
