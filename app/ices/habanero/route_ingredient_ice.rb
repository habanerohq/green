module Habanero
  module RouteIngredientIce
    extend ActiveSupport::Concern

    module InstanceMethods
      def adapt(klass)
        klass.send :include, Routable
      end
    end

    module Routable
      extend ActiveSupport::Concern

      module InstanceMethods
        def path
          route
        end

        def qualified_path
          if respond_to?(:parent) && parent && parent.respond_to?(:qualified_path)
            parent.qualified_path << path # code for qualifiying path here
          else
            path
          end
        end

        def draw_route(map)
        end
      end

      module ClassMethods
        def draw_routes(map)
          all.each { |t| t.draw_route(map) }
        end
      end
    end
  end
end

