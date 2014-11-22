module ADT
  class Constructor
    attr_reader :name, :klass, :others

    def initialize(parent, name, parameters, &block)
      @name = name
      @klass = Class.new(parent, &block)
      keys = parameters.keys
      types = parameters.values
      @klass.class_eval """
        attr_reader #{keys.map { |n| ":#{n}" }.join(', ')}

        def initialize(#{keys.join(", ")})
          arg_types = [#{keys.join(", ")}].map(&:class)
          unless arg_types.zip([#{types.join(", ")}]).all? { |arg_type, type| arg_type <= type }
            raise TypeError, 'Types mismatch: given ' + arg_types.join(', ') + ', expected #{types.join(", ")}'
          end
          #{keys.empty? ? "" : keys.map{ |n| "@#{n}" }.join(',') + " = " + keys.join(", ")}
        end

        def ==(other)
          other.is_a?(self.class) && #{keys.empty? ? "true" : keys.map { |key| "#{key} == other.#{key}"}.join(" && ")}
        end
      "
      @parameters = parameters
      @others = []
    end

    def to_s
      "#{@name}(#{@parameters})"
    end

    def inspect
      to_s
    end

    def |(other)
      @others << other
      self
    end
  end
end