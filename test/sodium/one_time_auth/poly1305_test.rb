require 'test_helper'

describe Sodium::OneTimeAuth::Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sod