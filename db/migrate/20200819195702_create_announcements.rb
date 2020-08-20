class CreateAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :announcements, id: :uuid do |t|
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
