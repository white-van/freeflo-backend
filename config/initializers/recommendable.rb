require 'redis'

Recommendable.configure do |config|
  # Recommendable's connection to Redis
  config.redis = Redis.new(host: 'localhost', port: 6379, db: 0)

  config.orm = :active_record_uuid

  # Whether or not to automatically enqueue users to have their recommendations
  # refreshed after they like/dislike an item
  config.auto_enqueue = true

  # The name of the queue that background jobs will be placed in
  config.queue_name = :recommendable

  # The number of nearest neighbors (k-NN) to check when updating
  # recommendations for a user. Set to `nil` if you want to check all
  # other users as opposed to a subset of the nearest ones.
  config.nearest_neighbors = nil

  # Like kNN, but also uses some number of most dissimilar users when
  # updating recommendations for a user. Because, hey, disagreements are
  # just as important as agreements, right? If `nearest_neighbors` is set to
  # `nil`, this configuration is ignored. Set this to a lower number
  # to improve Redis memory usage.
  #
  # Default: nil
  config.furthest_neighbors = nil

  # The number of recommendations to store per user. Set this to a lower
  # number to improve Redis memory usage.
  #
  # Default: 100
  config.recommendations_to_store = 100
end
