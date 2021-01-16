class MakeProjectIdInVersionsOptional < ActiveRecord::Migration[6.0]
  def change
    remove_column :versions, :project_id
  end
end
