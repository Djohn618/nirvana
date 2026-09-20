class CreateMemberships < ActiveRecord::Migration[8.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :role
      t.index [:user_id, :group_id], unique: true
      
      t.timestamps
    end
  end
end
