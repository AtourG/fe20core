
[![Gem Version][gem-badge]][gem-url]
[![Build Status][travis-badge]][travis-url]
[![Dependency Status][gemnasium-badge]][gemnasium-url]
[![Code Climate][codeclimate-badge]][codeclimate-url]
[![Coverage Status][coveralls-badge]][coveralls-url]

sodium
======

`sodium` is a Ruby binding to the easy-to-use high-speed crypto library [`libsodium`][libsodium] (which itself is based on [Daniel J. Bernstein][djb]'s [`NaCl`][nacl]). `NaCl`'s goal, and thus this project's, is to provide all the core operations necessary to build high-level cryptographic tools.

`NaCl` improves upon existing libraries with improved security through tight coding standads, improved usability, and significantly boosted performance.

Why Sodium?
-----------

`sodium` exports the functions provided by `libsodium` in an object-oriented, Rubylike manner using a very thin [FFI][ffi] wrapper. It thus provides all the benefits of using the `libsodium` C library directly: simplicity, performance, and security.

This library is tightly focused on providing only modern primitives and operations, giving users as few ways as possible to shoot themselves in the foot. While *no* crypto library can prevent all classes of user error, this library at least attempts to minimize the possibility of known, easily-preventable types of user error such as the use of broken primitives, reliance on non-authenticated encryption modes, and composition of low-level primitives to perform tasks for which well-studied high-level operations already exist.

Libraries like [OpenSSL][openssl] pack in support for every cryptographic primitive, protocol, and operation under the sun. Many of these supported features are cryptographically broken and preserved only so developers can maintain compatibility with older software. This is explicitly *not* a goal of `sodium`. While we will provide migration paths away from any primitives discovered to be weak or broken, we will never introduce known-bad primitives (e.g., MD5 or SHA-1) or easy-to-fuck-up operations (e.g., CBC mode) for the sake of interoperability.

Security
--------

The underlying cryptographic functions and APIs have been designed, chosen, and implemented by professional cryptographers. `sodium` itself, however, has not. No guarantees are made about its security nor suitability for any particular purpose.

If believe you have discovered a security vulnerability in the `sodium` wrapper, contact me at `sodium (at) touset (dot) org`. Please encrypt your message using the project's [GPG key][gpg-key] (fingerprint: `1E71 12A4 9424 2358 F6C8 727D C947 F58B FFCE E0D7`).