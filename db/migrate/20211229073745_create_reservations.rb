class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :member, null: false
      t.references :schedule, null: false
      t.string :payment, null: false
      t.integer :chiket_sheet, null: true
      t.integer :total_sheets, null: true
      t.datetime :confirm_time, null: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
