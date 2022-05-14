require 'rake/testtask'

Rake::TestTask.new 'test' => 'libsodium:compile' do |t|
  t.l