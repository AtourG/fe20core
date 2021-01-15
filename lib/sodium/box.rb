require 'sodium'

class Sodium::Box
  include Sodium::Delegate

  def self.keypair
    public_