class User < ApplicationRecord
  has_secure_password
  has_many :projects
  belongs_to :organization, optional: true
end
