class Project < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  has_many :branches, dependent: :delete_all
  has_many :versions, through: :branches
  has_many :contributions, dependent: :delete_all
  has_many :contributors, through: :contributions, foreign_key: 'user_id', class_name: 'User'
end
