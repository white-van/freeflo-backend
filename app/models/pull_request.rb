class PullRequest < ApplicationRecord
  belongs_to :branch
  belongs_to :user
  has_many :versions, through: :branches
end
