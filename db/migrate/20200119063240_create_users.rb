class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, :limit=>20, null:false
      t.string :password, :limit=>20, null:false
      t.string :email, :limit=>100, null:false, :unique=>true
      t.integer :fails_count, null:false, default: 0
      t.timestamp :last_login_at, null:true

      t.timestamps
    end
  end
end
