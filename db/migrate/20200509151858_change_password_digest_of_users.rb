class ChangePasswordDigestOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :password_digest, :string, :limit=>60, null:false
  end
end
