class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.boolean :approval, default: false

      t.timestamps
    end
    add_index :relationships, :from_user_id
    add_index :relationships, :to_user_id
    add_index :relationships, [:from_user_id, :to_user_id], unique: true
  end
end
