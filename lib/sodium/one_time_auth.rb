require 'sodium'

class Sodium::OneTimeAuth
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end

  def initialize(key)
    @key = self.class._ke