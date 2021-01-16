class Project < ApplicationRecord
  belongs_to :user
  belongs_to :organization, optional: true
  belongs_to :source_fork, class_name: 'Project', optional: true
  has_many :forks, class_name: 'Project', foreign_key: 'source_fork_id'
  has_many :versions

  # This may not work
  has_many :forked_versions, through: :source_fork

  def a_fork?
    source_fork_id.present?
  end

  # TODO: Fork functionality is hard
  def versions
    return versions unless a_fork?
  end
end
