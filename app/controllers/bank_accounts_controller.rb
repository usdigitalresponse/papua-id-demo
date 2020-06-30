class BankAccountsController < ApplicationController
  before_action :set_applicant

  # GET /bank_accounts/new
  def new
    if session[:enable_factorybot].present?
      @bank_account = FactoryBot.build(:bank_account, last_name: @applicant.last_name, first_name: @applicant.first_name, applicant_id: @applicant.id)
    end
    @bank_account ||= BankAccount.new(applicant_id: @applicant.id)
  end

  # POST /bank_accounts
  def create
    if @bank_account = BankAccount.create(bank_account_params.to_h.merge(applicant_id: @applicant.id))
      # calling a protected method here:
      #@bank_account.applicant.make_decision

      redirect_to new_applicant_document_url(@bank_account.applicant)
    else
      render :new
    end
  end

  protected

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:first_name, :last_name, :bank_account_number, :bank_routing_number, :applicant_id)
  end
end
