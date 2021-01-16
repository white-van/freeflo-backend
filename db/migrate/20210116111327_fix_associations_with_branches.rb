class FixAssociationsWithBranches < ActiveRecord::Migration[6.0]
  def change
    remove_column :pull_requests, :project_id
    add_reference :pull_requests, :branch, foreign_key: true

    remove_column :versions, :project_id
    add_reference :versions, :branch, foreign_key: true
  end
end
