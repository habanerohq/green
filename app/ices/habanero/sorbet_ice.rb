module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace
      validates :namespace, :presence => true

      has_many :ingredients
      
      validates :name, :uniqueness => { :scope => :namespace_id }
      
      before_create :mix! # failed create leaves empty table?
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
        namespace.klass.const_set(name, Class.new(ActiveRecord::Base))

        begin
          klass.send :include, "#{qualified_name}Ice".constantize
        rescue NameError => e
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