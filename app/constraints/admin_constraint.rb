class AdminConstraint
  def matches?(request)
    request.define_singleton_method(:application_requires_login_in_admin_constraint) { true }
    return false unless request.session[:user_id]
    User.find(request.session[:user_id]).present?
  end
end
