class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show]

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
    if params[:example_with_ln].present?
      @applicant = FactoryBot.build(:applicant, last_name: params[:example_with_ln])
    end
    @applicant ||= Applicant.new
  end

  # POST /applicants
  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to @applicant, notice: 'Applicant was successfully created.'
    else
      render :new
    end
  end

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :birthdate, :email_address, :phone_number, :street_address, :city, :state, :postal_code, :ssn, :case_number)
  end
end
