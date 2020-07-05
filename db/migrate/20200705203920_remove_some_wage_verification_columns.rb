class RemoveSomeWageVerificationColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :wage_verifications, :reported_wages
    remove_column :wage_verifications, :reported_time_period
  end
end
