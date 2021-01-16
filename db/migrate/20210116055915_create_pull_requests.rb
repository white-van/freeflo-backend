class CreatePullRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :pull_requests do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.bigint :reviewers, array: true
      t.boolean :accepted
      t.timestamps
    end
    add_index :pull_requests, :reviewers, using: 'gin'
  end
end
