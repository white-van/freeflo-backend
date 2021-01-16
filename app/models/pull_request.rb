class PullRequest < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :versions
end
