require 'sodium'

class Sodium::Hash
  include Sodium::Delegate

  def self.hash(message)
    message = _message(message)

    Sodium::Buffer.empty self.implementation[:BYTES] do |digest|
      self.implementation.nacl(
        digest .to_ptr,
        message.to_ptr,
        message.bytesize
      ) or raise Sodium::CryptoError, 'failed to gen