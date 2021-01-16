class User < ApplicationRecord
  has_secure_password
  api_guard_associations refresh_token: 'refresh_tokens',
                         blacklisted_token: 'blacklisted_tokens'
  has_many :refresh_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all

  has_many :projects
  belongs_to :organization, optional: true

  recommends :projects
end
