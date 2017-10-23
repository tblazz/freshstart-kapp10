class CreateEditions < ActiveRecord::Migration[5.0]
  def change
    create_table :editions do |t|
      t.date :date
      t.string :description
      t.integer :event_id

      t.timestamps
    end
  end
end
