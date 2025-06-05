class AddAboutToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :about, :text
  end
end
