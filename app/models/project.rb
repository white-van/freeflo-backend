class Project < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  has_many :branches
  has_many :versions, through: :branches
end
