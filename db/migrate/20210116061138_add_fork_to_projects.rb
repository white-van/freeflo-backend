class AddForkToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :fork_id, :bigint
  end
end
