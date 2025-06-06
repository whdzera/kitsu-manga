class CreateProfileComments < ActiveRecord::Migration[8.0]
  def change
    create_table :profile_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
