
require 'test_helper'

describe Sodium::Buffer do
  subject { Sodium::Buffer }

  def trigger_gc!
    GC.start
    1_000_000.times { Object.new }
    GC.start
  end

  it '::key must securely generate random keys of specified length' do
    Sodium::Random.stub(:bytes, lambda {|l| ' ' * l }) do
      subject.key( 7).to_s.must_equal(' ' *  7)
      subject.key( 8).to_s.must_equal(' ' *  8)
      subject.key(16).to_s.must_equal(' ' * 16)
      subject.key(32).to_s.must_equal(' ' * 32)
      subject.key(64).to_s.must_equal(' ' * 64)
    end
  end

  it '::nonce must securely generate random nonces of specified length' do
    Sodium::Random.stub(:bytes, lambda {|l| ' ' * l }) do
      subject.nonce( 7).to_s.must_equal(' ' *  7)
      subject.nonce( 8).to_s.must_equal(' ' *  8)
      subject.nonce(16).to_s.must_equal(' ' * 16)
      subject.nonce(32).to_s.must_equal(' ' * 32)
      subject.nonce(64).to_s.must_equal(' ' * 64)
    end
  end

  it '::empty must generate an empty buffer of specified length' do
    subject.empty(32).to_s.must_equal("\0" * 32)
    subject.empty(40).to_s.must_equal("\0" * 40)
  end

  it '::empty must yield to a block when given' do
    mock = MiniTest::Mock.new
    mock.expect :flag, nil

    subject.empty(5) {|buffer| mock.flag }

    mock.verify
  end

  it '::ljust must pad zero bytes on the end' do
    subject.ljust('xyz', 5).to_s.must_equal "xyz\0\0"
  end

  it '::ljust must not pad bytes when not needed' do
    subject.ljust('xyz', 2).to_s.must_equal 'xyz'
  end

  it '::rjust must pad zero bytes onto the front' do
    subject.rjust('xyz', 5).to_s.must_equal "\0\0xyz"
  end

  it '::rjust must not pad bytes when not needed' do
    subject.rjust('xyz', 2).to_s.must_equal 'xyz'
  end

  it '::lpad must prepend the required number of bytes' do
    subject.lpad('xyz', 0).to_s.must_equal 'xyz'
    subject.lpad('xyz', 2).to_s.must_equal "\0\0xyz"
  end

  it '::rpad must append the required number of bytes' do
    subject.rpad('xyz', 0).to_s.must_equal 'xyz'
    subject.rpad('xyz', 2).to_s.must_equal "xyz\0\0"
  end

  it '::new must create a buffer containing the specified string' do
    subject.new('xyz'     ).to_s.must_equal('xyz')
    subject.new('xyz' * 50).to_s.must_equal('xyz' * 50)
  end

  it '::new must do optional length checking' do
    lambda { subject.new('xyz', 4).to_s }.
      must_raise Sodium::LengthError
  end

  it '#initialize must freeze its bytes' do
    subject.new('s').to_ptr.must_be :frozen?
    subject.new('s').to_s  .must_be :frozen?
  end

  it '#initialize must wipe the memory from the original string' do
    'test'.tap do |s|
      subject.new(s)
    end.must_equal("\0" * 4)
  end

  it '#initialize must accept ZeroingDelegator-wrapped strings' do
    lambda { subject.new subject.new('xyz').to_s }.call.
      wont_equal TypeError
  end

  it '#initialize must wipe the buffer during finalization'
  it '#initialize must prevent the string from being paged to disk'

  it '#== must compare equality of two buffers' do
    subject.new('xyz').must_be :==, 'xyz'
    subject.new('xyz').wont_be :==, 'xy'
    subject.new('xyz').wont_be :==, 'xyzz'
    subject.new('xyz').wont_be :==, 'abc'
  end
