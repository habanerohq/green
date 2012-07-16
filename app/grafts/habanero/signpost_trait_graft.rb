module Habanero
  module SignpostTraitGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send :include, Routable
    end

    module Routable
      extend ActiveSupport::Concern

      def path
        signpost || ''
      end

      def qualified_path
        @qualified_path ||= if respond_to?(:parent) && parent && parent.respond_to?(:qualified_path)
          parent.qualified_path + path # code for qualifiying path here
        else
          path
        end
      end

      def label_signpost(map)
      end

      module ClassMethods
        def label_signposts(map)
          all.each { |t| t.label_signpost(map) }
        end
      end
    end
  end
end

