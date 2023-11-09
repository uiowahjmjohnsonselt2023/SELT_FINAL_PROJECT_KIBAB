class AddSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string
    add_index :users, :session_token ## this creates :id column in params NOT user_id
  end
end
