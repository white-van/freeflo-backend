class AddNewProjectsToVersions < ActiveRecord::Migration[6.0]
  def change
    add_reference :versions, :project, foreign_key: true
    add_reference :versions, :pull_request, foreign_key: true
  end
end
