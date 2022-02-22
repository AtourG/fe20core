module Sodium
  class Error       < ::StandardError; end
  class LengthError < Error;           end
  class CryptoError < Error;           end
  class MemoryError < Error;           end
end

# require 'sodium/version'

# core classes used by other modules
require 'sodium/delegate'
require 'sodium/buffer'
require 'sodium/random'

# object-oriented bindings to FFI
require 'sodiu