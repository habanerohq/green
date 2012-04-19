module Habanero
  module CategoryIngredientGraft
    extend ActiveSupport::Concern

    def adapt(klass)
      klass.send :belongs_to, method_name.to_sym, :class_name => 'Habanero::Category', :foreign_key => column_name
    end

    def column_name
      "#{method_name}_id"
    end

    def method_name
      name.attrify
    end

    def column_type
      :integer
    end

    protected

    def change_columns
      if name_was and name_changed?
        rename_column "#{name_was.attrify}_id", column_name
      end
    end
  end
end
