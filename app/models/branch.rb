class Branch < ApplicationRecord
  belongs_to :project
  has_many :versions, dependent: :delete_all
end
