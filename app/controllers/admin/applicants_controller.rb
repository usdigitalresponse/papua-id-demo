class Admin::ApplicantsController < Admin::AdminController
  before_action :set_applicant, only: [:show, :show2]
  before_action :search, only: [:index, :show, :dashboard]

  def dashboard
    @dashboard = true
    @applicant_mode = :tr
    @nav_selection = :dashboard
    render :index
  end

  def index
    @applicant_mode = :tr
    @nav_selection = :claims
  end

  def show
    @applicant_mode = :li
    @nav_selection = :claims
  end

  def show2
  end

  protected

  def set_applicant
    @applicant = Applicant.includes(:line_item_decisions).find(params[:id])
  end

  def search
    @applicants = Applicant.all.includes(:line_item_decisions).order(created_at: :desc)
    @applicants = @applicants.global_search(params["query"]) if params["query"].present?
  end
end
