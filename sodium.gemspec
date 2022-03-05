Gem::Specification.new do |gem|
  gem.name    = 'sodium'
  gem.version = File.read('VERSION') rescue '0.0.0'

  gem.author = 'Stephen Touset'
  gem.email  = 'stephen@touset.org'

  gem.homepage    = 'https://github.com/stouset/sodium'
  gem.summary     = 'A Ruby binding to the easy-to-use high-speed crypto library libsodium'
  gem.description = 'A library for performing cryptography based on modern ciphers and protocols'
  gem.license = 'MIT'

  gem.bindir      = 'bin'
  gem.fil