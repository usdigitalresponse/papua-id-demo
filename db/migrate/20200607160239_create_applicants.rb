class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants, id: :uuid do |t|
      t.string :first_name, limit: 64
      t.string :last_name, limit: 64
      t.date :birthdate
      t.string :email_address, limit: 128
      t.string :phone_number, limit: 32
      t.string :street_address, limit: 128
      t.string :city, limit: 64
      t.string :state, limit: 2
      t.string :postal_code, limit:5
      t.integer :ssn
      t.string :case_number, limit: 32

      t.timestamps
    end
  end
end
