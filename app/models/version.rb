class Version < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  belongs_to :pull_request, optional: true

  def in_pull_request?
    pull_request_id.present?
  end

  # TODO: Test
  def previous_version
    source = in_pull_request? ? pull_request : project
    source.versions.where.not('versions.id = ?', id).first(order: 'versions.id DESC', limit: 1)
  end
end
