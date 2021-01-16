class PullRequest < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  has_many :versions, through: :branches

  def self.latest_version
    versions.order('created_at DESC').first
  end
end
