class WageVerificationsController < ApplicationController
  before_action :set_applicant

  # GET /wage_verifications/new
  def new
    if session[:enable_factorybot].present?
      @wage_verification = FactoryBot.build(:wage_verification, applicant_id: @applicant.id)
    end
    @wage_verification = WageVerification.new
  end

  # POST /wage_verifications
  def create
    if @wage_verification = WageVerification.new(wage_verification_params.to_h.merge(applicant_id: @applicant.id))
      redirect_to new_applicant_document_url(@wage_verification.applicant)
    else
      render :new
    end
  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  # Only allow a trusted parameter "white list" through.
  def wage_verification_params
    params.require(:wage_verification).permit(:applicant_id, :reported_wages, :reported_employer_name, :reported_employer_id, :reported_time_period, :reported_termination_date)
  end
end
