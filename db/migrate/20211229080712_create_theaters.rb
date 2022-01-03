class CreateTheaters < ActiveRecord::Migration[5.2]
  def change
    create_table :theaters do |t|
      t.string :store_name, null: false
      t.string :address, null: false
      t.string :tel, null: false

      t.timestamps
    end
  end
end
