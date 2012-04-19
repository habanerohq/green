module Habanero
  module VarietyGraft
    extend ActiveSupport::Concern

    included do
      belongs_to :brand, :class_name => '::Habanero::Brand'
      has_many :ingredients,
               :class_name => '::Habanero::Ingredient',
               :inverse_of => :variety,
               :dependent => :destroy

      acts_as_nested_set

      scope :branded, lambda { |n| joins(:brand).where('habanero_brands.name = ?', n) }

      validates :name,
                :presence => true,
                :uniqueness => { :scope => :brand_id }

      validates_associated :ingredients

      before_create :create_table # failed create leaves empty table?
      after_destroy :remove_const

      unloadable
    end

    def qualified_name
      "#{brand.qualified_name}::#{klass_name}"
    end

    def primary_ingredients
      primary_mask.present? ? primary_mask.ingredients : all_displayable_ingredients
    end

    def primary_mask
      all_masks.detect { |m| m.primary? }
    end
    
    def all_masks
      self_and_ancestors.includes(:masks).map(&:masks).flatten.reverse
    end
    
    def all_ingredients
      self_and_ancestors.includes(:ingredients).map(&:ingredients).flatten
    end

    def displayable_ingredients(ingreds = nil)
      (ingreds || ingredients).
      reject do |i| 
        i.type.in? ['Habanero::RelationIngredient', 'Habanero::SlugIngredient'] or
          (i.type == 'Habanero::AssociationIngredient' and i.relation == 'has_many')
      end
    end

    def all_displayable_ingredients
      displayable_ingredients(all_ingredients)
    end
    
    def connections
      h = all_ingredients.select { |i| i.relation =~ /has/ }
      p = h.select { |i| i.primary? }
      p.any? ? p : h
    end
    
    def name_ingredient
      all_ingredients.detect{ |i| i.type == 'Habanero::NameIngredient' }
    end
    
    def name_ingredient_column_name
      name_ingredient.try(:method_name) || (respond_to?(:name) ? :name : :id)
    end

    def table_name
      base.qualified_name.pluralize.attrify
    end

    def klass_name
      name
    end

    def chill!
      return klass if chilled?

      brand.klass.const_set(klass_name, Class.new(parent.klass))
      klass.unloadable

      klass.class_attribute :_variety
      klass._variety = self
      klass.table_name = table_name

      adapt

      begin
        # fixme: syntax errors (at least) in the ice are ignored and results in failing
        #        to include the ice at all, silently
        klass.send :include, "#{qualified_name}Graft".constantize
      rescue NameError => e
        e.message =~ /#{qualified_name}Graft$/ ? nil : raise
      end

      klass
    end

    def chilled?
      brand.klass.constants.include?(klass_name)
    end

    def klass
      brand.klass.const_get(klass_name)
    end

    def base
      if parent
        parent.self_and_ancestors.detect(&:parent)
      end || self
    end

    def adapt
      ingredients.each { |i| i.adapt(klass) }
    end
    
    def post_create
      if !respond_to?(:suppress_automatic_naming) or (respond_to?(:suppress_automatic_naming) and !suppress_automatic_naming?)
        begin
          ni = Habanero::NameIngredient.create!(:name => 'Name', :variety => self)
          Habanero::SlugIngredient.create!(:name => 'Slug', :variety => self, :target => ni)
        rescue ActiveRecord::UnknownAttributeError => e
          nil
        rescue NameError => e
          e.message =~ /Ingredient$/ ? nil : raise
        end
      end
    end

    protected

    def create_table
      if parent
#          puts "create_table #{table_name}" unless connection.table_exists?(table_name) # write this to a log!
        connection.create_table(table_name) unless connection.table_exists?(table_name)
      end
    end

    def remove_const
      brand.klass.send(:remove_const, klass_name) if chilled?
    end
  end
end