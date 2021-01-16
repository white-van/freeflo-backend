class RenameForkIdToSourceForkId < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :fork_id
    add_column :projects, :source_fork_id, :bigint
  end
end
