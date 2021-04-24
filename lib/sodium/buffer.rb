require 'sodium'
require 'securerandom'

class Sodium::Buffer
  def self.key(size)
    Sodium::Random.bytes(size)
  end

  def self.nonce(size)
    Sodium::Random.bytes(size)
  end

  def self.empty(size)
    self.new("\0" * size).tap {|buffer| yield buffer if block_given? }
  end

  def self.ljust(string, size)
    size = (size > string.bytesize) ? size : s