require 'rake/clean'

require 'rbconfig'
require 'digest/sha2'

LIBSODIUM_MIRROR  = ENV['LIBSODIUM_MIRROR']  || "https://github.com/jedisct1/libsodium/tarball/%s"
LIBSODIUM_VERSION = ENV['LIBSODIUM_VERSION'] || 'master'
LIBSODIUM_DIGEST  = ENV['LIBSODIUM_DIGEST']  || nil

LIBSODIUM_URL       = LIBSODIUM_MIRROR % LIBSODIUM_VERSION
LIBSODIUM_PATH      = "libsodium-#{LIBSODIUM_VERSION}"
LIBSODIUM_TARBALL   = "build/#{LIBSODIUM_PATH}.tar.gz"
LIBSODIUM_BUILD     = "build/#{LIBSODIUM_PATH}"
LIBSODIUM_LIBDIR    = "#{LIBSODIUM_BUILD}/src/libsodium/.libs"
LIBSODIUM_LIB       = "libsodium.a"
LIBSODIUM           = "#{LIBSODIUM_LIBDIR}/#{LIBSODIUM_LIB}"

namespace :libsodium do
  directory LIBSODIUM_BUILD

  fi