class ValidateWagesJob < ApplicationJob
  queue_as :default

  def perform(wages_id)
    wages = WageVerification.find(wages_id)

    wages.reported_employer_id = get_id_for_employer_name
    wages.processing_status = "In Progress"
    wages.truework_verification_status = "Started"
    wages.decision = -2
    case(applicant.ssn.to_i)
    when EXAMPLES[:TrueworkStillProcessing]
      wages.truework_verification_status = "In Progress"
    when EXAMPLES[:TrueworkDeniedNoEmploymentFound]
      wages.truework_verification_status = "Rejected - No Employment history found"
      wages.decision = -1
    else
      get_validated_truework_response(wages)
    end

    wages.save
  end

  protected
  def get_id_for_employer_name
    # Normally we'd call the TrueWork API to get IDs for this employer, but lets just return a random number
    return rand(1000000)
  end

  def get_validated_truework_response(wage_verification)
    # Here we would call TrueWork and get the actual information
    wage_verification.verified_employer_name = wage_verification.reported_employer_name
    wage_verification.verified_employer_id = wage_verification.reported_employer_id
    wage_verification.verified_time_period = %w(Weekly Monthly Annually).sample
    plausible_weekly_wage = (rand(10000...50000) / 100.00).round(2)
    wage_verification.verified_wages =
      case(wage_verification.verified_time_period)
      when 'Weekly'
        plausible_weekly_wage
      when 'Monthly'
        plausible_weekly_wage * 5
      when 'Annually'
        plausible_weekly_wage * 52
      end
    wage_verification.verified_termination_date = wage_verification.reported_termination_date
    wage_verification.truework_verification_status = "completed"
    wage_verification.processing_status = 1
    wage_verification.decision = 1
  end
end