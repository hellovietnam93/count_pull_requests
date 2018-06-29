class CreateQueryConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :query_conditions do |t|
      t.text :content
      t.integer :repository_id
      t.integer :user_id

      t.timestamps
    end
    add_index :query_conditions, :repository_id
    add_index :query_conditions, :user_id
  end
end
