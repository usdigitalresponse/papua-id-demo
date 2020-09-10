class TrueWorkIncomeValidationJob < ApplicationJob
  queue_as :default

  def perform(validation_id, addl_info = {})
    validation = TrueWorkIncomeValidation.find(validation_id)
    if validation.state == Validation.statuses[:started]
        validation.initiate_validation
    elsif validation.state == Validation.statuses[:in_process]
        validation.poll_validation(addl_info)
    else
        raise "Error: TrueWorkIncomeValidationJob.perform called on validation in state #{validation.state}"
    end
  end
end
