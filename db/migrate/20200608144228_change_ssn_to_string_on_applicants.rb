class ChangeSsnToStringOnApplicants < ActiveRecord::Migration[6.0]
  def change
    change_column :applicants, :ssn, :string
  end
end
