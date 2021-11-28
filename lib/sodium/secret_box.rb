require 'sodium'

class Sodium::SecretBox
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end