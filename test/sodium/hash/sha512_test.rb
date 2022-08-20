
require 'test_helper'

describe Sodium::Hash::SHA512 do
  include SodiumTestHelpers

  let (:klass)     { Sodium::Hash::SHA512 }
  let (:primitive) { :sha512 }

  let :constants do
    { :BYTES => 64 }
  end