class ApplicantsController < ApplicationController
  include MainFlow
  before_action :set_applicant, only: [:show, :initialize_income_verification]
  before_action :set_session_params_from_switches, only: [:new]

  def show
    wait_on -> { @applicant.processed? }
  end

  # GET /applicants/new
  def new
    if session[:enable_factorybot].present?
      @applicant = FactoryBot.build(:applicant, forced_params)
    end
    @applicant ||= Applicant.new
  end

  # POST /applicants
  def create
    @applicant = Applicant.new(applicant_params.except(:example_with_ln))

    if @applicant.save
      respond_to do |format|
        format.html { redirect_to next_controller_url(@applicant) }
        format.json { render json: @applicant.as_json }
      end
    else
      render :new
    end
  end

  protected

  def set_session_params_from_switches
    # Handle setting the session params from those switches:
    # HAVE to set this to true/false - if left nil, they are not set to false/nil but rather ERASED from the session:
    session['enable_factorybot'] = params[:enable_factorybot] ? true : false
    session['enable_documents'] = params[:enable_documents] ? true : false
    session['enable_bank_accounts'] = params[:enable_bank_accounts] ? true : false
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :birthdate, :email_address, :phone_number, :street_address, :city, :state, :postal_code, :ssn, :case_number)
  end

  def forced_params
    params.require(:applicant).permit(:ssn).to_h.delete_if { |k,v| v.blank? }
  end
end
