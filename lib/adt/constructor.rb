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
          types = [#{keys.join(", ")}].map(&:class)
          raise TypeError, 'Types mismatch: given ' + types.join(', ') + ', expected #{types.join(", ")}' unless types == [#{types.join(", ")}]
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