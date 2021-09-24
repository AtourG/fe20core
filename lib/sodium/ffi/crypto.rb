
require 'sodium/ffi'
require 'yaml'

module Sodium::FFI::Crypto
  CONFIG_PATH = File.expand_path('../../../../config/nacl_ffi.yml', __FILE__)
  CONFIG      = YAML.load_file(CONFIG_PATH)

  def self._install_default(delegate, configuration)
    family    = configuration[:family]
    method    = _install_function delegate, family, nil, :PRIMITIVE, [ :string ]
    primitive = delegate.send(method)
  rescue FFI::NotFoundError
    primitive = configuration[:primitives].first
  ensure
    delegate.const_set :DEFAULT, primitive.to_s.downcase.to_sym
  end

  def self._install_primitives(delegate, configuration)
    configuration[:primitives].each do |primitive|
      subclass = Class.new(delegate) do
        def self.[](name)
          self.const_get(name)
        end
      end

      delegate.const_set primitive, subclass

      _install_constants subclass, configuration[:family], primitive,
        configuration[:constants]

      _install_functions subclass, configuration[:family], primitive,
        configuration[:functions]
    end
  end

  def self._install_constants(subclass, family, primitive, constants)
    constants = constants.inject(
      :PRIMITIVE => :string
    ) {|hash, constant| hash.update(constant => :size_t) }

    constants.each_pair do |name, type|
      _install_constant(subclass, family, primitive, name, type)
    end
  end

  def self._install_constant(subclass, family, primitive, name, type)
    method = _install_function subclass, family, primitive, name, [ type ]

    family = family.to_s.upcase
    name   = name.to_s.upcase
    value  = subclass.send(method)

    self.    const_set("#{family}_#{primitive}_#{name}", value)
    subclass.const_set(name,                             value)
  end

  def self._install_functions(subclass, family, primitive, methods)
    methods.each do |name, arguments|
      _install_function(subclass, family, primitive, name, arguments, &:zero?)
    end