require 'test_helper'

describe Sodium::Hash::SHA256 do
  include SodiumTestHelpers

  let (:klass)     { Sodium::Hash::SHA256 }
  let (:primitive) { :sha256 }

  let :constants do
    { :BYTES => 32 }
 