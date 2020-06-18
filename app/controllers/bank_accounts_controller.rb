class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:show]

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
    @bank_account = BankAccount.new(bank_account_params)

    if @bank_account.save
      redirect_to @bank_account, notice: 'Bank account was successfully stored.'
    else
      render :new
    end
  end

  def set_bank_account
    @bank_account = BankAccount.find(params[:id])
  end

  def bank_account_params
    params.require(:bank_account).permit(:first_name, :last_name, :bank_account_number, :bank_routing_number)
  end
end