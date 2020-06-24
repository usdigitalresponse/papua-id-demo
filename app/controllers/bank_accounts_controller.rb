class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show]
  MAX_APPLICANTS_PER_ACCOUNT = 2

  def show
    case @bank_account.decision
    when 'Approved'
      'success'
    when 'Manual Review'
      'warning'
    when 'Denied'
      'danger'
    end
  end

  # GET /bank_accounts/new
  def new
    if params[:example_with_ln].present?
      @bank_account = FactoryBot.build(:bank_account, last_name: params[:example_with_ln])
    end
    @bank_account ||= BankAccount.new
  end

  # POST /bank_accounts
  def create
    if BankAccount.count(bank_account_params.permit(:bank_account_number, :bank_routing_number)) > MAX_APPLICANTS_PER_ACCOUNT

    end

    @bank_account = BankAccount.new(bank_account_params)

    if @bank_account.save
      @bank_account.applicant.make_decision

      redirect_to applicant_path(@bank_account.applicant)
    else
      render :new
    end
  end

  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:first_name, :last_name, :bank_account_number, :bank_routing_number, :applicant_id)
  end
end