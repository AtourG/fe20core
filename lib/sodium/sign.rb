require 'sodium'

class Sodium::Sign
  include Sodium::Delegate

  def self.keypair
    public_key = Sodium::Buffer.empty self.implementation[:PUBLICKEYBYTES]
    secret_key = Sodium::Buffer.empty self.implementation[:SECRETKEYBYTES]

    self.implementation.nacl_keypair(
      public_key.to_ptr,
      secret_key.to_ptr
    ) or raise Sodium::CryptoError, 'failed to generate a keypair'

    return secret_key, public_key
  end

  def self.verify(key, message, signature)
    key       = self._public_key(key)
    signature = self._signature(message, signature)
    message   = Sodium::Buffer.empty(signature.bytesize)
    mlen      = FFI::MemoryPointer.new(:ulong_long, 1, true)

    self.implementation.nacl_open(
      message   .to_ptr,
      mlen,
      signature .to_ptr,
      signature .bytesize,
      key       .to_ptr
    )
  end

  def initialize(key)
    @key = self.class._secret_key(key)
  end

  def sign(message)
    message   = self.class._message(message)
    signature = Sodium::Buffer.empty(message.bytesize + self.implementation[:BYTES])
    slen      = FFI::MemoryPointer.new(:ulong_long, 1, true)

    self.implementation.nacl(
      signature .to_ptr,
      slen,
      message   .to_ptr,
      message   .bytesize,
      @key      .to_ptr
    ) or raise Sodium::CryptoError, 'failed to generate signature'

    # signatures actually encode the message itself at the end, so we
    # slice o