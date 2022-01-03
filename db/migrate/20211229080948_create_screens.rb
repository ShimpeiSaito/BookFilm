class CreateScreens < ActiveRecord::Migration[5.2]
  def change
    create_table :screens do |t|
      t.integer :screen_no, null: false
      t.references :theater, null: false
      t.integer :seat_group, null: false

      t.timestamps
    end
  end
end
