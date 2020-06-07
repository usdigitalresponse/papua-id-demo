class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  # GET /applicants/new
  def new
    @applicant = Applicant.new
  end

  # POST /applicants
  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to new_applicant_url, notice: 'Applicant was successfully created.'
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
