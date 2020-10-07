class Admin::TrueworkIncomeVerificationsController < Admin::AdminController
  include MainFlow
  before_action :set_applicant, only: [:new, :create, :show, :index]
  before_action :set_verification, only: [:show]

  # GET /applicants/:applicant_id/income_verifications/new
  def new
  	@verification = TrueworkIncomeVerification.new
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
  	v = TrueworkIncomeVerification.verify_applicant(@applicant, params['truework_income_verification'])
  	redirect_to admin_applicant_truework_income_verification_path(@applicant, v)
  end

  # GET /truework_income_verifications/:id
  def show
  end

  # GET /applicants/:applicant_id/income_verifications
  def index
  	@verifications = Verification.where(applicant: @applicant)
  end

  protected

  def set_applicant
    if params.has_key?(:applicant_id)
      @applicant = Applicant.find(params[:applicant_id])
    else
      set_verification
      @applicant = @verification.applicant
    end
  end

  def set_verification
    @verification ||= Verification.find(params[:id])
  end
end
