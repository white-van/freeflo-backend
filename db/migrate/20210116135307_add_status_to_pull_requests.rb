class AddStatusToPullRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :pull_requests, :status, :string
  end
end
