class Admin::ApplicantsController < Admin::AdminController
  before_action :set_applicant, only: [:show]

  def index
    @applicants = Applicant.for_current_workflow.order(created_at: :desc)
  end

  def show

  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end
end
