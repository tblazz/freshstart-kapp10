class CreateTotals < ActiveRecord::Migration[5.0]
  def change
    create_table :totals do |t|
      t.references :runner, index: true
      t.integer :points
      t.datetime :date

      t.timestamps
    end
  end
end
