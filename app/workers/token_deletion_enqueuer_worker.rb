class TokenDeletionEnqueuerWorker
  include Sidekiq::Worker

  def perform(*args)
    BlacklistedToken.where('expire_at < ?', Time.current).find_in_batches(batch_size: 100) do |group|
      group.pluck(:id).each { |token_id| BlacklistedTokenWorker.perform_async(token_id) }
    end
  end
end
