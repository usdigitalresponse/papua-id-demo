class ApplicationController < ActionController::Base
  around_action :set_locale

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def set_locale(&action)
    locale = (params[:locale] if I18n.available_locales.include?(params[:locale])) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def wait_on(condition, &block)
    render 'shared/wait' and return unless condition.()
    yield if block_given?
  end
end
