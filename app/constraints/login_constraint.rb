class LoginConstraint
  def matches?(request)
    return false unless request.path.exclude? 'rails/active_storage'
    request&.application_requires_login_in_admin_constraint
  end
end
