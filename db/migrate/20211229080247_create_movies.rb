class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :explanation, null: false
      t.date :released_at, null: false
      t.date :expired_at, null: false
      t.integer :screening_time, null: false
      t.text :distribution, null: false
      t.string :director, null: false

      t.timestamps
    end
  end
end
