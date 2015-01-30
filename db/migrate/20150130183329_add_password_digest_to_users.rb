class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
  end
end
