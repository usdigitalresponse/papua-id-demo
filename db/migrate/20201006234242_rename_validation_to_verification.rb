class RenameValidationToVerification < ActiveRecord::Migration[6.0]
  def change
  	rename_table :validations, :verifications
  	rename_column :line_item_decisions, :validation_id, :verification_id
  end

  def up
  	Product.connection.execute("UPDATE verifications SET type = 'TrueworkIncomeVerification' WHERE type = 'TrueWorkIncomeValidation'")
  	Product.connection.execute("UPDATE verifications SET type = 'AlloyIdentityVerification' WHERE type = 'AlloyIdentityValidation'")
  end

  def down
  	Product.connection.execute("UPDATE verifications SET type = 'TrueWorkIncomeValidation' WHERE type = 'TrueworkIncomeVerification'")
  	Product.connection.execute("UPDATE verifications SET type = 'AlloyIdentityValidation' WHERE type = 'AlloyIdentityVerification'")
  end
end
