class Admin::TrueworkIncomeVerificationsController < Admin::AdminController
  include MainFlow
  before_action :set_applicant, only: [:new, :create, :show, :index]
  before_action :set_verification, only: [:show]

  # GET /applicants/:applicant_id/income_verifications/new
  def new
  	@verification = TrueWorkIncomeValidation.new
  	@verification.input = {
  		"first_name" => @applicant.first_name,
  		"last_name" => @applicant.last_name,
  		"social_security_number" => "000-00-0001", # This SSN is mocked out to succeed.  See mocks in config\initializers\truework.rb
  		"email" => @applicant.email_address,
  		"company_id" => 20733 # This is a legit company ID (Zendesk)
  	}
  end

  # POST /applicants/[ID]/income_verifications/create
  def create
  	v = TrueWorkIncomeValidation.validate_applicant(@applicant, params['true_work_income_validation'])
  	redirect_to admin_applicant_truework_income_verification_path(@applicant, v)
  end

  # GET /applicants/:applicant_id/income_verifications/:id
  def show
  end

  # GET /applicants/:applicant_id/income_verifications
  def index
  	@verifications = Validation.where(applicant: @applicant)
  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def set_verification
    @verification = Validation.find(params[:id])
  end
end
