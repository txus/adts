require "adt/version"
require "adt/constructor"

module ADT
end

def ADT(&block)
  Class.new.tap do |klass|
    o = Object.new

    o.define_singleton_method(:method_missing) do |m, *args, &block|
      ADT::Constructor.new(klass, m, args.first || {}, &block)
    end

    first = o.instance_eval(&block)
    [first, *first.others].each do |tc|
      klass.const_set(tc.name, tc.klass)
      klass.singleton_class.send(:define_method, tc.name) do |*args|
        const_get(tc.name).new(*args)
      end
    end
  end
end
