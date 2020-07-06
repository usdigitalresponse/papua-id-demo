class DocumentsController < ApplicationController
  include MainFlow

  before_action :set_applicant

  def new
    @document = @applicant.documents.new()
  end

  def create
    @document = @applicant.documents.create(document_params)
    redirect_to next_controller_url(@applicant)
  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def document_params
    params.require(:document).permit(:file, :document_type)
  end
end
