class Admin::ApplicantsController < Admin::AdminController
  def index
    @applicants = Applicant.for_current_workflow
  end
end
