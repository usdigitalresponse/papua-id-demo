class CreateWageVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :wage_verifications, id: :uuid do |t|
      t.decimal :reported_wages
      t.string :reported_employer_name
      t.string :reported_employer_id
      t.string :reported_time_period
      t.date :reported_termination_date
      t.decimal :verified_wages
      t.string :verified_employer_name
      t.string :verified_employer_id
      t.string :verified_time_period
      t.date :verified_termination_date
      t.string :truework_verification_status
      t.string :verification_status

      t.timestamps
    end
  end
end
