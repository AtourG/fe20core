namespace :compile do
  LIB_PATH   = File.expand_path('../../lib',        __FILE__)
  EXT_PATH   = File.expand_path('../../ext/sodium', __FILE__)

  MEMORY_PATH = File.join EXT_PATH,    'memory'
  MEMORY_SRC  = File.join MEMORY_PATH, '*.c'
  MEMORY_LIB  = 'memory.' + RbConfi