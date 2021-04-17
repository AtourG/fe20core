require 'sodium'
require 'securerandom'

class Sodium::Buffer
  def self.key(size)
    Sodium::Random.bytes(si