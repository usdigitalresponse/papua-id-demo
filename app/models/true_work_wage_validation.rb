class TrueWorkWageValidation < WageValidation

  def self.job_class
  	TrueWorkWageValidationJob
  end

  def validate
  	self.update_attributes(status: :in_process)
  	# TODO: Get TrueWorks API endpoint wrapper
  	# Call API (remember to handle timeouts, errors, etc.)
  	# Use info in self.input to know what to pass to TrueWorks
  	self.update_attributes(status: :complete, decision: :approved)
  end
end
