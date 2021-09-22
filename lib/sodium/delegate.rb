
require 'sodium'

module Sodium::Delegate
  def self.included(base)
    base.send :extend, ClassMethods