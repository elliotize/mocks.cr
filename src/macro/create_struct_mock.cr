module Mocks
  module Macro
    macro create_struct_mock(name, &block)
      struct ::{{name.id}}
        @@__mocks_name = "{{name.id}}"

        include ::Mocks::BaseMock
        {{block.body}}
      end

      class ::Mocks::InstanceDoubles{{name.id}} < ::Mocks::BaseDouble
        @@name = "Mocks::InstanceDoubles{{name.id}}"

        def ==(other)
          self.same?(other)
        end

        def ==(other : Value)
          false
        end

        macro mock(method_spec)
          mock(\{{method_spec}}, nil, ::{{name.id}}.allocate)
        end

        {{block.body}}
      end
    end
  end
end
