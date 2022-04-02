require 'rake/clean'

require 'rbconfig'
require 'digest/sha2'

LIBSODIUM_MIRROR  = ENV['LIBSODIUM_MIRROR']  || "https://github.com/jedisct1/libsodium/tarball/%s"
LIBSODIUM_VERSION = ENV['LIBSODIU