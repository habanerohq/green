module Habanero
  module SorbetIce
    extend ActiveSupport::Concern

    included do
      belongs_to :namespace
      validates_presence_of :namespace

      has_many :ingredients
      
      validates :name, :uniqueness => { :scope => :namespace_id }
    end
    
    module InstanceMethods
      def qualified_name
        "#{namespace.qualified_name}::#{name}" # todo: qualify name into class name
      end

      def chill!
        namespace.klass.const_set(name, Class.new(ActiveRecord::Base))
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