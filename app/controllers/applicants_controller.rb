class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show]
  before_action :set_session_params_from_switches, only: [:new]

  def show
    case @applicant.descision
    when 'Approved'
      'success'
    when 'Manual Review'
      'warning'
    when 'Denied'
      'danger'
    end
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
      redirect_to new_applicant_bank_account_url(@applicant, example_with_ln: applicant_params[:example_with_ln])
    else
      render :new
    end
  end

  protected

  def set_session_params_from_switches
    # Handle setting the session params from those switches:
    session[:enable_factorybot] = params[:enable_factorybot]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :birthdate, :email_address, :phone_number, :street_address, :city, :state, :postal_code, :ssn, :case_number, :example_with_ln)
  end

  def forced_params
    params.require(:applicant).permit(:ssn).to_h.delete_if { |k,v| v.blank? }
  end
end
