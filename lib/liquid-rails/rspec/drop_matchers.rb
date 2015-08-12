module Liquid
  module Rails
    module Rspec
      module DropMatchers
        def have_attribute(name)
          AttributeMatcher.new(name)
        end

        def have_many(name)
          AssociationMatcher.new(name, type: :has_many)
        end

        def belongs_to(name)
          AssociationMatcher.new(name, type: :belongs_to)
        end

        def have_scope(name)
          ScopeMatcher.new(name)
        end

        class AttributeMatcher
          attr_reader :name, :actual

          def initialize(name)
            @name = name
          end

          def matches?(actual)
            @actual = actual

            attributes.include?(name)
          end

          def description
            "have attribute #{name}"
          end

          def failure_message
            %Q{expected #{actual.inspect} to define "#{name}" as attribute}
          end

          def failure_message_when_negated
            %Q{expected #{actual.inspect} not to define "#{name}" as attribute}
          end

          private

            def drop
              if actual.is_a?(Class)
                actual
              else
                actual.class
              end
            end

            def attributes
              drop._attributes
            end
        end

        class AssociationMatcher
          attr_reader :name, :actual, :options

          def initialize(name, options)
            @name    = name
            @options = options
          end

          def matches?(actual)
            @actual = actual

            association = associations[name]
            result = association.present? && association[:type] == options[:type]
            result = result && association[:options][:scope] == options[:scope]           if options[:scope]
            result = result && association[:options][:with] == options[:with]             if options[:with]
            result = result && association[:options][:class_name] == options[:class_name] if options[:class_name]

            result
          end

          def with(class_name)
            @options[:with] = class_name
            self
          end

          def scope(scope_name)
            @options[:scope] = scope_name
            self
          end

          def class_name(class_name)
            @options[:class_name] = class_name
            self
          end

          def description
            "have association #{name}"
          end

          def failure_message
            %Q{expected #{actual.inspect} to define "#{name}" as :#{options[:type]} association}
          end

          def failure_message_when_negated
            %Q{expected #{actual.inspect} not to define "#{name}" as :#{options[:type]} association}
          end

          private

            def drop
              if actual.is_a?(Class)
                actual
              else
                actual.class
              end
            end

            def associations
              drop._associations
            end
        end

        class ScopeMatcher
          attr_reader :name, :actual

          def initialize(name)
            @name = name
          end

          def matches?(actual)
            @actual = actual

            scopes.include?(name)
          end

          def description
            "have scope #{name}"
          end

          def failure_message
            %Q{expected #{actual.inspect} to define "#{name}" as scope}
          end

          def failure_message_when_negated
            %Q{expected #{actual.inspect} not to define "#{name}" as scope}
          end

          private

            def drop
              if actual.is_a?(Class)
                actual
              else
                actual.class
              end
            end

            def scopes
              drop._scopes
            end
        end
      end
    end
  end
end