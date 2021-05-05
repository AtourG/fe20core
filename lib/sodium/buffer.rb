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
    size = (size > string.bytesize) ? size : string.bytesize

    self.empty(size) do |buffer|
      buffer[0, string.bytesize] = string
    end
  end

  def self.rjust(string, size)
    size = (size > string.bytesize) ? size : string.bytesize

    self.empty(size) do |buffer|
      buffer[size - string.bytesize, string.bytesize] = string
    end
  end

  def self.lpad(string, size, &block)
    self.rjust(string, string.bytesize + size, &block)
  end

  def self.rpad(string, size, &block)
    self.ljust(string, string.bytesize + size, &block)
  end

  def self.new(bytes, size = bytes.bytesize)
    raise Sodium::LengthError, "buffer must be exactly #{size} bytes long" unless
      bytes.bytesize == size

    bytes.kind_of?(self) ?
      bytes  