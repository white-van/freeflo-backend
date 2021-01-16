class Project < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  belongs_to :original, class_name: 'Project', optional: true
  has_many :forks, class_name: 'Project', foreign_key: 'fork_id'

  def forked?
    fork_id.present?
  end
end
