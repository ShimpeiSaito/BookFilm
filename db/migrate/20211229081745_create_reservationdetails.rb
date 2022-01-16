class CreateReservationdetails < ActiveRecord::Migration[5.2]
  def change
    create_table :reservationdetails do |t|
      t.references :reservation, null: false
      t.references :ticket, null: true
      t.string :seat, null: true

      t.timestamps
    end
  end
end
