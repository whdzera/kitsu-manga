class RenameProfileIdInProfileComments < ActiveRecord::Migration[8.0]
  def change
    drop_table :profile_comments, if_exists: true

    create_table :profile_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :profile_user, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.timestamps
    end
  end
end
