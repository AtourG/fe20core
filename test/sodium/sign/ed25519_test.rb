require 'test_helper'

describe Sodium::Sign::Ed25519 do
  include SodiumTestHelpers

  subject { self.klass.new(self.s