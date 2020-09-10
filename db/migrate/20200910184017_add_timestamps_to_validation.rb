class AddTimestampsToValidation < ActiveRecord::Migration[6.0]
  def change
  	change_table(:validations) { |t| t.timestamps }
  end
end
