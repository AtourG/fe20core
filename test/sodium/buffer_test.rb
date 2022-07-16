
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