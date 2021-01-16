class AddMissingProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :full_name, :string, null: false
    add_column :pull_requests, :name, :string, null: false
  end
end
