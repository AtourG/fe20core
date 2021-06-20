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
      bytes              :
      super(bytes)
  end

  def initialize(bytes)
    # unwrap ZeroingDelegator if present
    bytes = bytes.to_str

    # allocate enough memory on the heap to store the bytes
    pointer = Sodium::FFI::LibC.calloc(1, bytes.bytesize)

    # use the ZeroingDelegator helper methods to prevent the pointer
    # from being swapped to disk, to wipe its memory on garbage
    # collection, and to attach our own finalizer to free() the memory
    # on garbage collection as well
    ZeroingDelegator._mlock!          pointer, bytes.bytesize
    ZeroingDelegator._finalize! self, pointer, bytes.bytesize,
      &self.class._finalizer(pointer, bytes.bytesize)

    # now that the pointer can't be swapped out to disk, it is safe to
    # write memory contents to it
    pointer.write_string(bytes)

    # zero out the bytes passed to us, since we can't control their
    # lifecycle
    ZeroingDelegator._mwipe!(bytes, bytes.bytesize)

    # WARNING: The following section is critical. Edit with caution!
    #
    # We create a new pointer to the bytes allocated earlier and set a
    # hidden instance variable pointing at ourself. We do the latter
    # so that there is a cyclic dependency between the buffer and the
    # pointer; if either is still live in the current scope, it is
    # enough to prevent the other from being collected. We create the
    # new pointer since the existing pointer is referenced by the
    # finalizer; if we didn't, its reference in the finalizer proc
    # would keep us from being garbage collected because it holds a
    # pointer to us.
    @bytesize = bytes.bytesize
    @bytes    = FFI::Pointer.new(pointer.address)
    @bytes.instance_variable_set(:@_sodium_buffer, self)

    @bytes.freeze
    self  .freeze
  end

  def ==(bytes)
    self.to_s == Sodium::Buffer.new(bytes)
  end

  def +(bytes)
    Sodiu