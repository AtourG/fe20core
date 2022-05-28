require 'test_helper'

describe Sodium::Auth::HMACSHA256 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::Auth::HMACSHA256 }
  let(:primitive) { :hmacsha256 }

  let :constants do
    { :BYTES    => 32,
      :KEYBYTES => 32, }
  end

  let_64(:key)           { 'XM