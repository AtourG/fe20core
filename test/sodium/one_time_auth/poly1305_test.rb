require 'test_helper'

describe Sodium::OneTimeAuth::Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::OneTimeAuth::Poly1305 }
  let(:primitive) { :poly1305 }

  let :constants do
    { :BYTES    => 16,
      :KEYBYTES => 32, }
  end

  let_64(:key)           { 'tZUeTVtSHOfgOei4DUwCt10xqrIYhALpO08NIDMWFB0=' }
  let_64(:authenticator) { 'n+6StqC6