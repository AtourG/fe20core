require 'sodium'

class Sodium::OneTimeAuth
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[