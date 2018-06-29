class CreatePullRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :pull_requests do |t|
      t.string :author
      t.string :pr_id
      t.string :pull_request
      t.integer :plus_code
      t.integer :minus_code
      t.integer :query_condition_id

      t.timestamps
    end

    add_index :pull_requests, :query_condition_id
  end
end
