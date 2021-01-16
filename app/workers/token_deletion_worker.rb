class TokenDeletionWorker
  include Sidekiq::Worker

  def perform(token_id)
    token = BlacklistedToken.find_by(id: token_id)
    token&.destroy
  end
end
