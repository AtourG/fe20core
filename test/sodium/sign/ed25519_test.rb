require 'test_helper'

describe Sodium::Sign::Ed25519 do
  include SodiumTestHelpers

  subject { self.klass.new(self.secret_key) }

  let(:klass)     { Sodium::Sign::Ed25519 }
  let(:primitive) { :ed25519 }

  let :constants do
    { :BYTES          => 64,
      :PUBLICKEYBYTES => 32,
      :SECRETKEYBYTES => 64, }
  end

  let_64(:secret_key) { 'PZstPgy/LfTLN47rK69qHv9FPFRhoNRrIcjrxpIl4U0PhSflLvk7kqOrVPJdefT0Cvdwhx7Nyss0TItOCvPH4g==' }
  let_64(:public_key) { 'D4Un5S75O5Kjq1TyXXn09Ar3cIcezcrLNEyLTgrzx+I=' }
  let_64(:plaintext)  { 'bWVzc2FnZQ==' }
  let_64(:signature)  do
    %{ gBIV6VdlmL9aicHsrWMYhqGiQg3t1QGWmuj5oUNI2DN6FeaKKIkjPZ/N7vTM
       R7ebY7+C7teQJMSrxlqTnrcnCw== }
  end

  it '::primitive must be correct' do
    self.klass.primitive.must_equal self.primitive
  end

  it 'must have correct values for its constants' do
    self.constants.each_pair do 