require 'sodium'

class Sodium::Auth
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end

  def self.auth(key, message)
    key     = self._key(key)
    message = self._message(message)

    Sodium::Buffer.empty self.implementation[:BYTES] do |authenticator|
      self.implementation.nacl(
        authenticator.to_ptr,
        message      .to_ptr,
        message      .bytesi