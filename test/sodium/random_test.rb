require 'test_helper'

describe Sodium::Random do
  subject { Sodium::Random }

  it '::bytes must generate a byte string of desired length' do
    subject.bytes( 30).bytesize.must_equal  30
    sub