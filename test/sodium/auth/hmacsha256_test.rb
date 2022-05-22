require 'test_helper'

describe Sodium::Auth::HMACSHA256 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:kl