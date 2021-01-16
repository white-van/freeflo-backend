class RenameStarsToHeartsInProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :stars_count
    add_column :projects, :heart_count, :bigint, default: 0
  end
end
