class DocumentsController < ApplicationController
  before_action :set_applicant

  def new
    @document = @applicant.documents.new()
  end

  def create
    @document = @applicant.documents.create(document_params)
    byebug
    redirect_to @applicant
  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def document_params
    params.require(:document).permit(:file, :document_type)
  end
end
