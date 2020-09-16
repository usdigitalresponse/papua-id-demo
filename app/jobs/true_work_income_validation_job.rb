class TrueWorkIncomeValidationJob < ApplicationJob
  queue_as :default

  def perform(validation_id)
    validation = TrueWorkIncomeValidation.find(validation_id)
    if validation.status == "started"
        validation.initiate_validation
    elsif validation.status == "in_process"
        validation.poll_validation
    else
        raise "Error: TrueWorkIncomeValidationJob.perform called on validation in state #{validation.status}"
    end
  end
end
