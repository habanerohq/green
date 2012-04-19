module Habanero
  module AssociationIngredientGraft
    extend ActiveSupport::Concern

    included do
      validates :relation,
                :presence => true,
                :inclusion => { :in => %w(belongs_to has_one has_many has_and_belongs_to_many) }

      validates :name,
                :presence => true
      
      before_save :null_blanks
    end

    def adapt(klass)
      return nil if klass.reflect_on_association(name.attrify.to_sym) or !has_inverse?

      options = {}

      # todo: refactor me :)
      if polymorphic?
        if relation == 'belongs_to'
          options[:polymorphic] = true
        else
          options[:as] = inverse_name.attrify
          options[:class_name] = "::#{inverse_variety.qualified_name}"
        end
      else
        options[:class_name] = "::#{inverse_variety.qualified_name}"
        options[:foreign_key] = inverse_column_name unless relation == 'belongs_to'
      end

      options.merge!(:order => inverse_position_name) if relation =~ /many/ and ordered?

#        puts "#{klass} #{relation}, #{name.attrify.to_sym}, #{options.inspect}" # todo: log me!
      klass.send relation, name.attrify.to_sym, options

      if ordered? and relation == 'belongs_to'
        klass.send :acts_as_list, :scope => name.attrify.to_sym, :column => position_name
      end
    end
    
    def has_inverse?
      inverse.present? or (associated_type.present? and associated_name.present?)
    end

    def inverse_variety
      inverse.present? ? inverse.variety : associated_type
    end

    def inverse_klass
      inverse_variety.klass
    end

    def inverse_name
      associated_name || inverse.name
    end
    
    def ordered?
      ordered || parent.try(:ordered?)
    end

    def polymorphic?
      read_attribute(:polymorphic) or siblings.count > 1
    end

    def columns_required?
      relation =~ /belongs_to/
    end

    def column_name
      "#{method_name}_id"
    end

    def inverse_column_name
      inverse.present? ? inverse.column_name : "#{associated_name.attrify}_id"
    end

    def method_name
      name.attrify
    end

    def position_name
      "#{method_name}_position"
    end

    def inverse_position_name
      inverse.present? ? inverse.position_name : "#{associated_name.attrify}_position"
    end

    def column_type
      :integer
    end
    
    def arel_column
      is = inverse_variety
      is.klass.arel_table[is.name_ingredient_column_name]
    end

    def apply_inclusions(query_chain)
      query_chain.includes(method_name)
    end

    protected
    
    def null_blanks
      self.associated_name = nil if respond_to?(:associated_name) and associated_name.blank?
    end

    def inverse
      if relation == 'belongs_to'
        siblings.detect.first unless polymorphic?
      else
        siblings.detect { |s| s.relation == 'belongs_to' }
      end
    end

    def add_columns
      if columns_required?
        begin
          add_column column_name, column_type unless column_exists?(column_name)
        rescue Exception => e
          puts self.inspect
        end
        add_column "#{name.attrify}_type", :string if polymorphic?

        if ordered?
          unless column_exists?(position_name)
            add_column position_name, column_type
          end
        end
      end

      if variety.chilled? && inverse
        adapt(variety.klass)
        inverse.adapt(inverse_variety.klass)
        inverse_variety.klass.reset_column_information
      end
    end

    def change_columns
      if columns_required? and name_was and name_changed?
        rename_column "#{name_was.attrify}_id", column_name
      end
    end

    def remove_columns
      remove_column(column_name) if columns_required?
    end
  end
end