class BasicObject
  def self.stub_any_instance(name, val_or_callable = nil, &block)
    new_name = "__minitest_any_instance_stub__#{name}"

    owns_method = instance_method(name).owner == self
    class_eval do
      alias_method new_name, name if owns_method

      if ::RUBY_VERSION >= "3"
        define_method(name) do |*args, **kwargs|
          if val_or_callable.respond_to?(:call)
            instance_exec(*args, **kwargs, &val_or_callable)
          else
            val_or_callable
          end
        end
      else
        define_method(name) do |*args|
          if val_or_callable.respond_to?(:call)
            instance_exec(*args, &val_or_callable)
          else
            val_or_callable
          end
        end
      end
    end

    yield
  ensure
    class_eval do
      remove_method name
      if owns_method
        alias_method name, new_name
        remove_method new_name
      end
    end
  end
end
