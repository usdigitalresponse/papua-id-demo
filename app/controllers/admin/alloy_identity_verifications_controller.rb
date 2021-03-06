class Admin::AlloyIdentityVerificationsController < Admin::AdminController
  before_action :set_verification, only: [:show]
  before_action :set_applicant, only: [:create]

  # POST /applicants/[ID]/income_verifications/create
  def create
    VerifyIdentityWithAlloyJob.perform_later(@applicant.id)
    redirect_to admin_applicant_url(@applicant), notice: 'Identity Verification Requested'
  end

  def show
  end

  protected

  def set_applicant
    @applicant = Applicant[params[:applicant_id]]
  end

  def set_verification
    @verification = AlloyIdentityVerification[params[:id]]
  end
end
