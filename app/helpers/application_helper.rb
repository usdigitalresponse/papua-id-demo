module ApplicationHelper
  @@personal_line_items = [:first_name, :last_name, :ssn, :birthdate, :street_address, :phone_number, :email_address]


  def applicant_line_item_decision_icon(applicant, line_item)
    if @@personal_line_items.any? line_item
      case applicant.line_item_decisions.find { |x| x.name == line_item.to_s}.decision.to_sym
      when :approved
        :check_circle
      when :rejected
        :times_circle
      when :pending
        :circle
      default
        :circle
      end
    end
  end
end
