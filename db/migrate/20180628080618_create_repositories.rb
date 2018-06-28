class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_index :repositories, :user_id
  end
end
