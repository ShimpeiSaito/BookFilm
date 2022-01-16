class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :theater, null: false
      t.references :movie, null: false
      t.integer :screen_no, null: false
      t.date :screening_date, null: false
      t.time :starttime, null: false
      t.time :endtime, null: false

      t.timestamps
    end
  end
end
