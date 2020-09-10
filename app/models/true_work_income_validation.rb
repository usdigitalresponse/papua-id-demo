require 'truework'
require 'base64'

class TrueWorkIncomeValidation < IncomeValidation

  def self.job_class
  	TrueWorkIncomeValidationJob
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
          first_name: input[:first_name],
          last_name: input[:last_name],
          social_security_number: input[:social_security_number],
          contact_email: input[:email],
          company: { id: input[:company_id] } # Applicant chooses company synchronously in UI
        },
        documents: [
          # TODO: Will we support any document types?
        ],
        additional_information: "This is a demo/test conducted by U.S. Digital Response"
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

        verification_info = {verification_id: verification_request[:id]}
        job_class.set(wait: check_back_hours.hours).perform_later(id, verification_info)
      end
    rescue Truework::ClientException, Truework::ServerException => e
        output = {
          error_info: e.to_s
        }
        update_attributes(status: :error, output: output)
    end
  end

  def poll_validation(verification_info)
    begin
      verification_request = Truework::VerificationRequest.retrieve(verification_info[:verification_id])
      case verification_request[:state]
      when "completed"
        report = Truework::Report.retrieve(verification_info[:verification_id])
        output = {
          employment_status: report[:status], # active, inactive, or unknown
          salary: report[:gross_pay],
          salary_frequency: report[:pay_frequency], # This is a string; not clear what allowed values are 
          employment_type: report[:employment_type], # regular-full-time, regular-part-time, contractor, or other
          earnings: report[:earnings] # There's potentially a lot of info here; do we want all of it?
        }
        update_attributes(status: :complete, output: output)
        # TODO: How does "self.decision" get set?
      when "canceled"
        output = {
          error_info: verification_request[:cancellation_reason],
          error_details: verification_request[:cancellation_details]
        }
        update_attributes(status: :error, output: output)
      when "invalid"
        # TODO: Can TrueWork tell us why our request is invalid?
        output = {
          error_info: "TrueWork indicates that request made by this app is invalid; this is probably a bug.  Further info is not available at this time."
        }
        update_attributes(status: :error, output: output)
      when "action-required"
        # TODO: How do we handle this case?
        output = {
          error_info: "TrueWork requires more information to process request, but we do not have a way to supply that information."
        }
        update_attributes(status: :error, output: output)
      else
        # Processing is not complete, poll again later
        check_back_hours = 1
        if verification_request[:turnaround_time]
          check_back_hours = verification_request[:turnaround_time][:lower_bound]
        end

        verification_info = {verification_id: verification_request[:id]}
        job_class.set(wait: check_back_hours.hours).perform_later(id, verification_info)
      end
    rescue Truework::ClientException, Truework::ServerException => e
        output = {
          error_info: e.to_s
        }
        update_attributes(status: :error, output: output)
    end
  end
end
