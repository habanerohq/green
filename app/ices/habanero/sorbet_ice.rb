module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace
      validates :namespace, :presence => true
      
      belongs_to :super_sorbet, :class_name => 'Sorbet', :foreign_key => :super_id

      has_many :ingredients
      
      validates :name, :uniqueness => { :scope => :namespace_id }
      
      before_create :mix! # failed create leaves empty table?
      after_create :chill!
    end
    
    module InstanceMethods
      def qualified_name
        "#{namespace.qualified_name}::#{name}" # todo: qualify name into class name
      end
      
      def table_name
        qualified_name.pluralize.underscore.gsub('/', '_')
      end
      
      def mix!
        connection.create_table(table_name) unless connection.table_exists?(table_name)
      end

      def chill!
        if super_sorbet # don't redefine edge classes ;)
          begin
            namespace.klass.send :remove_const, name
          rescue NameError
          end

          super_sorbet.chill!
          namespace.klass.const_set(name, Class.new(super_sorbet.klass))

          begin
            klass.send :include, "#{qualified_name}Ice".constantize
          rescue NameError => e
          end
        end
      end
      
      def klass
        begin
          qualified_name.constantize
        rescue NameError => e
          chill!
        end

        qualified_name.constantize
      end
    end
  end
end