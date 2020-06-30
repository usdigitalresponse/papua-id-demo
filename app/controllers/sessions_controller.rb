class SessionsController < ApplicationController
  def new
    redirect_to root_url and return if session[:user_id].present? && User.find(session[:user_id]).present?
    @redirect_path = params[:path]
  end

  def create
    redirect_to new_session_url, alert: I18n.t('session.new.incorrect') and return unless @logged_in_user = User.find_by(email: login_params[:email])&.authenticate(login_params[:password])
    session[:user_id] = @logged_in_user.id
    redirect_to login_params[:redirect_path].present? ? "/#{login_params[:redirect_path]}" : root_url
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to new_session_url, notice: I18n.t('session.new.logout')
  end

  protected

  def login_params
    params.permit(:email, :password, :redirect_path)
  end
end
