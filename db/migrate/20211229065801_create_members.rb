class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :login_id, null: false
      t.string :password, null: false
      t.string :name, null: false
      t.date :birthday, null: false
      t.string :tel, null:false
      t.string :email, null:false
      t.string :payment, null:false

      t.timestamps
    end
  end
end
