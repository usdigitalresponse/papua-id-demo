class LoginConstraint
  def matches?(request)
    request&.application_requires_login_in_admin_constraint
  end
end
