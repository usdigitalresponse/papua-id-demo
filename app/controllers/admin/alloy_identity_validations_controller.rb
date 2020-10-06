class Admin::AlloyIdentityValidationsController < Admin::AdminController
  before_action :set_verification, only: [:show]

  def show
  end

  protected

  def set_verification
    @verification = AlloyIdentityValidation[params[:id]]
  end
end

# HACK This needs to be merged with verifications controller as part of #175154418
