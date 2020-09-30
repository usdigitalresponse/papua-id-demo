class Admin::AlloyIdentityVerificationsController < Admin::AdminController
  before_action :set_applicant

  # POST /applicants/[ID]/income_verifications/create
  def create
  	ValidateIdentityWithAlloyJob.perform_later(@applicant.id)
    redirect_to admin_applicant_url(@applicant), notice: 'Identity Verification Requested'
  end

  protected

  def set_applicant
    @applicant = Applicant[params[:applicant_id]]
  end
end
