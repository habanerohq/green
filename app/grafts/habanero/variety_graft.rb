module Habanero
  module VarietyGraft
    extend ActiveSupport::Concern

    included do
      belongs_to :brand, :class_name => '::Habanero::Brand'
      has_many :traits,
               :class_name => '::Habanero::Trait',
               :inverse_of => :variety,
               :dependent => :destroy

      acts_as_nested_set

      scope :branded, lambda { |n| joins(:brand).where('habanero_brands.name = ?', n) }

      validates :name,
                :presence => true,
                :uniqueness => { :scope => :brand_id }

      validates_associated :traits

      before_create :create_table # failed create leaves empty table?
      after_destroy :remove_const

      unloadable
    end

    def qualified_name
      "#{brand.qualified_name}::#{klass_name}"
    end

    def primary_traits
      primary_highlighter.present? ? primary_highlighter.traits : all_displayable_traits
    end

    def primary_highlighter
      all_highlighters.detect { |m| m.primary? }
    end
    
    def all_highlighters
      self_and_ancestors.includes(:highlighters).map(&:highlighters).flatten.reverse
    end
    
    def all_traits
      self_and_ancestors.includes(:traits).map(&:traits).flatten
    end

    def displayable_traits(ingreds = nil)
      (ingreds || traits).
      reject do |i| 
        i.type.in? ['Habanero::RelationTrait', 'Habanero::SlugTrait'] or
          (i.type == 'Habanero::AssociationTrait' and i.relation == 'has_many')
      end
    end

    def all_displayable_traits
      displayable_traits(all_traits)
    end
    
    def connections
      h = all_traits.select { |i| i.relation =~ /has/ }
      p = h.select { |i| i.primary? }
      p.any? ? p : h
    end
    
    def name_trait
      all_traits.detect{ |i| i.type == 'Habanero::NameTrait' }
    end
    
    def name_trait_column_name
      name_trait.try(:method_name) || (respond_to?(:name) ? :name : :id)
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
      traits.each { |i| i.adapt(klass) }
    end
    
    def post_create
      if !respond_to?(:suppress_automatic_naming) or (respond_to?(:suppress_automatic_naming) and !suppress_automatic_naming?)
        begin
          ni = Habanero::NameTrait.create!(:name => 'Name', :variety => self)
          Habanero::SlugTrait.create!(:name => 'Slug', :variety => self, :target => ni)
        rescue ActiveRecord::UnknownAttributeError => e
          nil
        rescue NameError => e
          e.message =~ /Trait$/ ? nil : raise
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
