class Branch < ApplicationRecord
  belongs_to :project
  has_many :versions, dependent: :delete_all

  def most_recent_version_after(version_id = nil)
    return versions.order('created_at DESC').first unless version_id.present?

    versions.where.not('id = ?', version_id).order('created_at DESC').first
  end
end
