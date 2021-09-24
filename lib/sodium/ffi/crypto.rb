
require 'sodium/ffi'
require 'yaml'

module Sodium::FFI::Crypto
  CONFIG_PATH = File.expand_path('../../../../config/nacl_ffi.yml', __FILE__)
  CONFIG      = YAML.load_file(CONFIG_PATH)

  def self._install_default(delegate, configuration)