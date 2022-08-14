require 'test_helper'

describe Sodium::Hash::SHA256 do
  include SodiumTestHelpers

  let (:klass)     { Sodium::Hash::SHA256 }
  let (:primitive) { :sha256 }

  let :constants do
    { :BYTES => 32 }
  end

  let_64(:hash)      { 'q1MKE+RZFJgrefm34/uplM/R8/si9xzqGvvwK0YMbR0=' }
  let_64(:plaintext) { 'bWVzc2FnZQ==' }
