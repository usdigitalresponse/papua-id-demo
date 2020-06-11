class Admin::AdminController < ApplicationController
  before_action :authenticate

  protected

  def authenticate
    true # TODO: Admin lock
  end
end
