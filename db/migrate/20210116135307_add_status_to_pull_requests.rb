class AddStatusToPullRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :status, :string, default: 'pending', null: false
  end
end
