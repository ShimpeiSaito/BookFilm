class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :t_type, null: false
      t.integer :total, null: false

      t.timestamps
    end
  end
end
