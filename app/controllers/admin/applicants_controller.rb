class Admin::ApplicantsController < Admin::AdminController
  before_action :set_applicant, only: [:show, :update]
  before_action :search, only: [:index, :show]

  def index
    @nav_selection = :claims
  end

  def update
    @applicant.update(applicant_params)
    redirect_to admin_applicant_url(@applicant)
  end

  def show
    @nav_selection = :claims
  end

  def show2
  end

  protected

  def applicant_params
    params.require(:applicant).permit(:status)
  end

  def set_applicant
    @applicant = Applicant.includes(:line_item_decisions).find(params[:id])
    @audits = @applicant.audits
  end

  def search
    @applicants = Applicant.all.includes(:line_item_decisions)
    @applicants = @applicants.global_search(params["query"]) if params["query"].present?
    if params['sort'].present?
      # This is only safe in Rails 6:
      @applicants.order!("#{params['sort']} #{params['dir']}")
    else
      @applicants.order!(created_at: :desc)
    end
  end
end
