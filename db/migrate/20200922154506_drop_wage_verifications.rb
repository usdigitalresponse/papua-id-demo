class DropWageVerifications < ActiveRecord::Migration[6.0]
  def up
    drop_table :wage_verifications
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
