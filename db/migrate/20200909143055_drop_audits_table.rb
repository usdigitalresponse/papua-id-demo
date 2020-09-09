class DropAuditsTable < ActiveRecord::Migration[6.0]
  # The previously generated audits table used integer primary keys. As this app uses UUID primary keys, this table needs to be rebuilt.
  # Since there was previously a fundimental mismatch in primary key types, there cannot be valid audits, and the table can simply be dropped.
  def change
    drop_table :audits
  end
end
