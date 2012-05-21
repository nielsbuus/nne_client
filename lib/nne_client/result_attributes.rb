module NNEClient

  # ResultAttributes provides an attributes class method. When calling attributes
  # with a list of keys from the @hash instance variable a method are defined for
  # each key returning the value from the @hash. As such it requires a @hash
  # instance variable on the class that extends the module. Additionally it
  # ignores any value in the @hash that is itself a Hash. This is due to the way
  # the NNE SOAP API works together with Savon.
  #
  # Example:
  #
  #   class Foo
  #     extends NNEClient::ResultAttributes
  #     def initialize
  #       @hash = { :foo => 1, :bar => { :a => 2 }}
  #       attributes :foo, :bar
  #     end
  #   end
  #
  #   Foo.new.foo
  #     => 1
  #   Foo.new.bar
  #     => nil
  #
  # @!visibility private
  module ResultAttributes

    # Create a method for each key listed in attrs
    def attributes(*attrs)
      attrs.each do |attribute|
        define_method(attribute) do
          @hash[attribute] unless @hash[attribute].kind_of?(Hash)
        end
      end
    end

    # Create a method that converts to float for each key listed in attrs
    def float_attributes(*attrs)
      attrs.each do |attribute|
        define_method(attribute) do
          @hash[attribute].to_f unless @hash[attribute].kind_of?(Hash)
        end
      end
    end
  end
end
