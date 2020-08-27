module ApplicantsHelper
  def applicant_status_class(status)
    case status.to_sym
    when :verified
      :warning
    when :review
      :warning
    when :closed
      :success
    else
      :danger
    end
  end
end
