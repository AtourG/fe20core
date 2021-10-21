require 'sodium'

class Sodium::Hash
  include Sodium::Delegate

  def self.hash(message)
    message = _message(message)

    Sodium::Buffer.