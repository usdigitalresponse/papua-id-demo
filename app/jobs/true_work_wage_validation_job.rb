class TrueWorkWageValidationJob < ApplicationJob
  queue_as :default

  def perform(validation_id)
    validation = TrueWorkWageValidation.find(validation_id)
    validation.validate
  end
end
