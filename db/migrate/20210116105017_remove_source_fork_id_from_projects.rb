class RemoveSourceForkIdFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :source_fork_id
  end
end
