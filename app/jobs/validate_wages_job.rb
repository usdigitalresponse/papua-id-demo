class ValidateWagesJob < ApplicationJob
  queue_as :default

  def perform(wages_id)
    wages = WageVerification.find(wages_id)

    wages.reported_employer_id = get_id_for_employer_name
    wages.processing_status = 0
    wages.truework_verification_status = "Started"
    wages.decision = -2
    case(wages.applicant.ssn.to_i)
    when EXAMPLES[:TrueworkStillProcessing]
      wages.truework_verification_status = "In Progress"
    when EXAMPLES[:TrueworkDeniedNoEmploymentFound]
      wages.truework_verification_status = "Rejected - No Employment history found"
      wages.decision = -1
    when EXAMPLES[:TrueworkEmploymentDetailsAreClose]
      get_nearly_matching_truework_response(wages)
      wages.truework_verification_status = "Manual review needed - some details match"
      wages.decision = 0
    when EXAMPLES[:TrueworkEmploymentDetailsAreWayOff]
      get_way_off_truework_response(wages)
      wages.truework_verification_status = "Rejected - Employment details do not match"
      wages.decision = -1
    else
      get_fully_matching_truework_response(wages)
    end

    wages.save
  end

  protected
  def get_id_for_employer_name
    # Normally we'd call the TrueWork API to get IDs for this employer, but lets just return a random number
    return rand(1000000)
  end

  def get_fully_matching_truework_response(wage_verification)
    # Here we would call TrueWork and get the actual information
    wage_verification.verified_employer_name = wage_verification.reported_employer_name
    wage_verification.verified_employer_id = wage_verification.reported_employer_id
    wage_verification.verified_wages = wage_verification.reported_wages
    wage_verification.verified_time_period = wage_verification.reported_time_period
    wage_verification.verified_termination_date = wage_verification.reported_termination_date
    wage_verification.truework_verification_status = "Completed"
    wage_verification.processing_status = 1
    wage_verification.decision = 1
  end

  def get_nearly_matching_truework_response(wage_verification)
    wage_verification.verified_employer_name = wage_verification.reported_employer_name
    wage_verification.verified_employer_id = wage_verification.reported_employer_id
    wage_verification.verified_wages = wage_verification.reported_wages + (rand(-10000..10000) / 100.00)
    wage_verification.verified_time_period = wage_verification.reported_time_period
    wage_verification.verified_termination_date = wage_verification.reported_termination_date + (rand(-5..5)).days
    wage_verification.truework_verification_status = "Manual Verification - Data is close but does not match exactly"
    wage_verification.processing_status = 0
    wage_verification.decision = 0
  end

  def get_way_off_truework_response(wage_verification)
    wage_verification.verified_employer_name = wage_verification.reported_employer_name
    wage_verification.verified_employer_id = wage_verification.reported_employer_id
    wage_verification.verified_wages = wage_verification.reported_wages + (rand(1000..5000) * [-1, 1].sample)
    wage_verification.verified_time_period = wage_verification.reported_time_period
    wage_verification.verified_termination_date = wage_verification.reported_termination_date + (rand(-5..5)).days
    wage_verification.truework_verification_status = "Rejected - Data is way off from Truework"
    wage_verification.processing_status = -1
    wage_verification.decision = -1
  end
end