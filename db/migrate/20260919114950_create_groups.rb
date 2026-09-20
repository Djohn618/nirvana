class CreateGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :creator_id

      t.timestamps
    end
  end
end
