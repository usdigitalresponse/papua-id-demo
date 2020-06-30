class LoginConstraint
  def matches?(request)
    request.path.exclude? 'rails/active_storage' # && request&.application_requires_login_in_admin_constraint
  end
end
