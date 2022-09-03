require 'test_helper'

describe Sodium::OneTimeAuth::Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::OneTimeAuth::Poly1305 }
  let(:primitive) { :poly1305 }

  let :constants do
    { :