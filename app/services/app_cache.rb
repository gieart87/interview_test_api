class AppCache
  def self.fetch(key, expires_in: 10.minutes)
    Rails.cache.fetch(key, expires_in: expires_in) { yield }
  end

  def self.delete(key)
    Rails.cache.delete(key)
  end
end