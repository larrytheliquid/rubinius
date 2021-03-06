module Rubinius
  class RubyConfig
    def initialize
    end

    def get_variable(name)
      Ruby.primitive :vm_get_config_item
      raise PrimitiveFailure, "Unable to get config variable"
    end

    def get_section(section)
      Ruby.primitive :vm_get_config_section
      raise PrimitiveFailure, "Unable to get config section"
    end

    def section(section)
      ary = get_section(section)
      i = 0
      while i < ary.size
        tup = ary[i]
        yield tup[0], tup[1]
        i += 1
      end
    end

    def [](name)
      get_variable(name)
    end
  end

  RUBY_CONFIG = RubyConfig.new
end
