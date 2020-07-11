class AddMoreUserSubmittedColumnsToWageVerification < ActiveRecord::Migration[6.0]
  def change
    add_column :wage_verifications, :reported_wages, :decimal, null: false, default: 0
    add_column :wage_verifications, :reported_time_period, :string, nulL: false, default: ""
  end
end
