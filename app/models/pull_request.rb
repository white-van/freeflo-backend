class PullRequest < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  has_many :versions, through: :branches

  def self.latest_version
    branch.most_recent_version_after
  end
end
