class User < ApplicationRecord
  has_secure_password
  api_guard_associations refresh_token: 'refresh_tokens',
                         blacklisted_token: 'blacklisted_tokens'
  has_many :refresh_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all

  has_many :projects, dependent: :delete_all
  belongs_to :organization, optional: true

  recommends :projects

  def add_contribution(project_id)
    cont = Contribution.where(user_id: id).where(project_id: project_id)
    return true unless cont.empty?

    cont = Contribution.new({
                              user_id: id,
                              project_id: project_id
                            })
    cont.save
  end
end
