class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :login_id, null: false
      t.string :name, null: false
      t.date :birthday, null: false
      t.string :tel, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
