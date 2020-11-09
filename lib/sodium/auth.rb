require 'sodium'

class Sodium::Auth
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end

  def self.auth(key, message)
    key     = self._key(key)
    message = self._message(message)

    Sodium: