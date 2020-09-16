require 'truework'
require 'base64'

class TrueWorkIncomeValidation < IncomeValidation

  def self.job_class
  	TrueWorkIncomeValidationJob
  end

  def job_class
    self.class.job_class
  end

  def initiate_validation
    if !$truework_enabled
      raise "Truework integration not enabled, cannot validate"
    end

  	update_attributes(status: :in_process)

    begin
      verification_request = Truework::VerificationRequest.create(
        type: 'employment-income',
        permissible_purpose: 'employee-eligibility',
        target: {
          first_name: input["first_name"],
          last_name: input["last_name"],
          social_security_number: input["social_security_number"],
          contact_email: input["email"],
          company: { id: input["company_id"] } # Applicant chooses company synchronously in UI
        },
        documents: [
          # TODO: Will we support any document types?
        ],
        additional_information: addl_info
      )

      if verification_request[:state] == "canceled"
        # This is an error.
        output = {
          error_info: verification_request[:cancellation_reason],
          error_details: verification_request[:cancellation_details]
        }
        update_attributes(status: :error, output: output)
      else
        # Enqueued- we need to check back later to get the result
        check_back_hours = 1
        if verification_request[:turnaround_time]
          check_back_hours = verification_request[:turnaround_time][:lower_bound]
        end
        output = {verification_id: verification_request[:id]}
        update_attributes(output: output)

        job_class.set(wait: check_back_hours.hours).perform_later(id)
      end
    rescue Truework::ClientException, Truework::ServerException => e
        output = {
          error_info: e.to_s
        }
        update_attributes(status: :error, output: output)
    end
  end

  def addl_info
    # For testing purposes, the "additional_info" that we pass to Truework
    # will include some hints to request certain responses.  E.g. to test
    # a good response, and to test a response where they weren't able to
    # get income information.
    #
    # To make this easier for people doing demos, we'll base the response
    # on something that the person doing the demo has control over: the
    # social security number of the applicant.  We'll generate different
    # additional_info based on the last digit of the SSN.  We use the last
    # digit, since it's visible in the Truework dashboard.

    ssn = input["social_security_number"]
    if !ssn
      return "This is a demo/test conducted by U.S. Digital Response"
    end

    case ssn[-1]
    # "1" is "completed", but that's our default
    when "2"
      return "desired_state: action-required"
    when "3"
      return "desired_state: invalid"
    when "4"
      return "desired_state: canceled"
    # NOTE: We don't support `pending-approval` or `processing`.  If we demanded
    # those responses, then our polling would never complete.
    else
      return "desired_state: completed"
    end
  end

  def poll_validation
    begin
      verification_request = Truework::VerificationRequest.retrieve(output['verification_id'])
      case verification_request[:state]
      when "completed"
        report = Truework::Report.retrieve(output['verification_id'])
        new_output = output.merge({
          employment_status: report[:employee][:status], # active, inactive, or unknown
          salary: report[:employee][:salary][:gross_pay],
          salary_frequency: report[:employee][:salary][:pay_frequency], # This is a string; not clear what allowed values are 
          earnings: report[:employee][:earnings] # There's potentially a lot of info here; do we want all of it?
        })
        update_attributes(status: :complete, output: new_output)
        # TODO: How does "self.decision" get set?
      when "canceled"
        new_output = output.merge({
          error_info: verification_request[:cancellation_reason],
          error_details: verification_request[:cancellation_details]
        })
        update_attributes(status: :error, output: new_output)
      when "invalid"
        # TODO: Can TrueWork tell us why our request is invalid?
        new_output = output.merge({
          error_info: "TrueWork indicates that request made by this app is invalid; this is probably a bug.  Further info is not available at this time."
        })
        update_attributes(status: :error, output: new_output)
      when "action-required"
        # TODO: How do we handle this case?
        new_output = output.merge({
          error_info: "TrueWork requires more information to process request, but we do not have a way to supply that information."
        })
        update_attributes(status: :error, output: new_output)
      else
        # Processing is not complete, poll again later
        check_back_hours = 1
        if verification_request[:turnaround_time]
          check_back_hours = verification_request[:turnaround_time][:lower_bound]
        end

        job_class.set(wait: check_back_hours.hours).perform_later(id)
      end
    rescue Truework::ClientException, Truework::ServerException => e
      new_output = output.merge({
        error_info: e.to_s
      })
      update_attributes(status: :error, output: new_output)
    end
  end
end
