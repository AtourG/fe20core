require 'pathname'

module Sodium::FFI::Memory
  extend FFI::Library

  ffi_lib Pathname.new(__FILE__).dirname.join(
    %{memory.#