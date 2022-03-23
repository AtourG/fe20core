namespace :compile do
  LIB_PATH   = File.expand_path('../../lib',        __FILE__)
  EXT_PATH   = File.expand_path('../../ext/sodium', __FILE__)

  MEMORY_PATH = File.join EXT_PATH,    'memory'
  MEMORY_SRC  = File.join MEMORY_PATH, '*.c'
  MEMORY_LIB  = 'memory.' + RbConfig::CONFIG['DLEXT']

  desc 'Compile the memory extension'
  task :memory => %{#{LIB_PATH}/sodium/ffi/#{MEMORY_LIB}}

  file %{#{LIB_PATH}/sodium/ffi/#{MEMORY_LIB}} => FileList[MEMORY_SRC] do
  