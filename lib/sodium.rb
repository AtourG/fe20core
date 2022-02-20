module Sodium
  class Error       < ::StandardError; end
  class LengthError < Error;           end
  class CryptoError < Error;           end
  class MemoryError < Error;   