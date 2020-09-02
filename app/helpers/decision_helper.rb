module DecisionHelper
  PERSONAL_LINE_ITEMS = [:first_name, :last_name, :ssn, :birthdate, :address, :phone_number, :email_address].freeze
  BANK_ACCOUNT_LINE_ITEMS = [:bank_account_number, :bank_routing_number].freeze
  WAGE_VALIDATION_LINE_ITEMS = [:reported_employer_name, :reported_termination_date, :reported_wages, :reported_time_period].freeze

  def applicant_line_item_decision_icon(decision)
    case decision
    when "approved"
      "check_circle"
    when "rejected"
      "times_circle"
    else
      "question_circle"
    end
  end

  def applicant_line_item_decision_haml(applicant, line_item, text)
    line_item_decision = if PERSONAL_LINE_ITEMS.include? line_item
      applicant&.line_item_decisions.find { |x| x.name == line_item.to_s}
    elsif BANK_ACCOUNT_LINE_ITEMS.include? line_item
      applicant&.bank_account&.line_item_decisions&.find { |x| x.name == line_item.to_s}
    else
      applicant&.wage_verification&.line_item_decisions&.find { |x| x.name == line_item.to_s}
    end

    return content_tag :dd, class: decision_to_css_class(line_item_decision&.decision) do
      [
        content_tag(:a, text, href: '#', data: {container: :body, toggle: :popover, trigger: :focus, placement: :right, title: "#{line_item_decision&.name&.titleize} #{line_item_decision&.decision}", content: "#{line_item_decision&.name&.titleize} #{line_item_decision&.decision} in #{line_item_decision&.sources&.join(' and ')}."}),
        fa_icon(applicant_line_item_decision_icon(line_item_decision&.decision))
      ].join(' ').html_safe
    end
  end

  def decision_to_css_class(decision)
    case decision
    when "approved"
      "passed"
    when "rejected"
      "failed"
    when nil
      ""
    end
  end

  def decision_icon(decision, options={})
    case decision
    when 'Approved'
      text_class = 'text-success'
      icon_class = 'fas fa-check-circle'
    when 'Denied'
      text_class = 'text-danger'
      icon_class = 'fas fa-times-circle'
    when 'Manual Review'
      text_class = 'text-warning'
      icon_class = 'fas fa-user-circle'
    when 'unprocessed'
      text_class = 'text-secondary'
      icon_class = 'fas fa-question-circle'
    end
    icon_class << " fa-#{options[:size]}x" if options[:size].present?
    content_tag(:span, content_tag(:i, '', class: icon_class), class: text_class)
  end
end
