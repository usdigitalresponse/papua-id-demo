class RootController < ApplicationController
  def index
    @examples = %w[FraudRiskMR DOBMiskeyMR SSNWarningApprove NameNotVerifiedMR NameAddressNotVerifiedMR SSNWarningDeniedFraud SSNNotVerifiedMR DeviceWarningDenied BankAccountInvalid BankRoutingNumberInvalid]
  end
end
