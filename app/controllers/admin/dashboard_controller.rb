class Admin::DashboardController < Admin::AdminController
  def index
    @nav_selection = :dashboard
    @tasks = Task.all.includes(:applicant).order(due_on: :asc)
    @announcements = Announcement.all.order(created_at: :desc)
  end
end
