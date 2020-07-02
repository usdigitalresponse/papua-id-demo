module MainFlow
  extend ActiveSupport::Concern

  # Included just for reference:
  included do
    # before_action ...
  end

  CONTROLLER_ORDER = %w[
    applicants
    documents
    bank_accounts
    wage_verification
  ]

  def next_controller_url(*args)
    next_index = CONTROLLER_ORDER.find_index(self.class.name.underscore.gsub(/_controller/, '')) + 1
    while next_index < CONTROLLER_ORDER.count
      break if session["enable_#{CONTROLLER_ORDER[next_index]}"]
      next_index += 1
    end
    CONTROLLER_ORDER[next_index] ? self.public_send("new_applicant_#{CONTROLLER_ORDER[next_index].singularize}_url", *args) : url_for(*args)
  end
end
