class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.integer :seat_group, null: false
      t.string :line, null: false
      t.integer :start_line, null: false
      t.integer :ast_line, null: false
      t.integer :num, null: false

      t.timestamps
    end
  end
end
