class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: -> { request.format == :json }
  before_action :require_api_key, if: -> { request.format == :json }
  around_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def require_api_key
    render head: 403 and throw :abort unless secure_compare(Rails.application.credentials.api_key, request.headers['Authorization'])
  end

  def set_locale(&action)
    locale = (params[:locale] if I18n.available_locales.include?(params[:locale])) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def wait_on(condition, &block)
    render 'shared/wait' and return unless condition.()
    yield if block_given?
  end
end
