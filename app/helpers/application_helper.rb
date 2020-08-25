module ApplicationHelper
  @@personal_line_items = [:first_name, :last_name, :ssn, :birthdate, :street_address, :phone_number, :email_address]
  @@bank_account_line_items = [:bank_account_number, :bank_routing_number]
  @@wage_validation_line_items = [:reported_employer_name, :reported_termination_date, :reported_wages, :reported_time_period]

  def applicant_line_item_decision_icon(decision)
    case decision
    when "approved"
      ":check_circle"
    when "rejected"
      ":times_circle"
    else
      ":question_circle"
    end
  end

  def applicant_line_item_decision_haml(applicant, line_item, text)
    line_item_decision = if @@personal_line_items.include? line_item
      applicant.line_item_decisions.find { |x| x.name == line_item.to_s}.try(:decision)
    elsif @@bank_account_line_items.include? line_item
      applicant.bank_account.line_item_decisions.find { |x| x.name == line_item.to_s}.try(:decision)
    else
      applicant.wage_verification.line_item_decisions.find { |x| x.name == line_item.to_s}.try(:decision)
    end

    render_haml <<-HAML
      %dd#{decision_to_css_class(line_item_decision)}
        #{text}
        = fa_icon #{applicant_line_item_decision_icon(line_item_decision)}
    HAML
  end

  def decision_to_css_class(decision)
    case decision
    when "approved"
      ".passed"
    when "rejected"
      ".failed"
    when nil
      ""
    end
  end

  def render_haml(haml, locals = {})
    Haml::Engine.new(haml.strip_heredoc, format: :html5).render(self, locals)
  end
end
