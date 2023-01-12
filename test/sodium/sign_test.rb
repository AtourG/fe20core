require 'test_helper'

describe Sodium::Sign do
  include SodiumTestHelpers

  subject       { self.klass.new(self.keypair.first) }