class AddRoleToUsers < ActiveRecord::Migration[8.0]
  def change
        add_column :users, :role, :string, default: 'member'
      end
end
