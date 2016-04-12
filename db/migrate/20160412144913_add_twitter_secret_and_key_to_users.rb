class AddTwitterSecretAndKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter_key, :string
    add_column :users, :twitter_secret, :string
  end
end
