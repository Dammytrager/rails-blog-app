class AddUserToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :user_id, :integer, limit: 8
    add_foreign_key :articles, :users
  end
end
