class WageVerification < ApplicationRecord
  belongs_to :applicant

  after_create_commit :do_verification

  protected
  
  def do_verification
    # Simulate answers for each term
    self.reported_employer_id = get_id_for_employer_name
    self.verification_status = "In Progress"
    self.truework_verification_status = "Started"
    case(applicant.ssn.to_i)
    when EXAMPLES[:TrueworkStillProcessing]
      self.truework_verification_status = "In Progress"
    when EXAMPLES[:TrueworkDeniedNoEmploymentFound]
      self.truework_verification_status = "Completed"
      self.verification_status = "Rejected - No Employment history found"
    else
      get_validated_truework_response
    end

    self.save
  end

  def get_id_for_employer_name
    # Normally we'd call the TrueWork API to get IDs for this employer, but lets just return a random number
    return rand(1000000)
  end

  def get_validated_truework_response
    # Here we would call TrueWork and get the actual information
    self.verified_employer_name = self.reported_employer_name
    self.verified_employer_id = self.reported_employer_id
    self.verified_time_period = %w(Weekly Monthly Annually).sample
    plausible_weekly_wage = (rand(10000...50000) / 100.00).round(2)
    self.verified_wages =
      case(self.verified_time_period)
      when 'Weekly'
        plausible_weekly_wage
      when 'Monthly'
        plausible_weekly_wage * 5
      when 'Annually'
        plausible_weekly_wage * 52
      end
    self.verified_termination_date = self.reported_termination_date
    self.truework_verification_status = "completed"
    self.verification_status = "completed"
  end
end
