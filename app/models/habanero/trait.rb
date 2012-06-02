module Habanero
  class Trait < ActiveRecord::Base
    include Habanero::Graft

    belongs_to :variety, :inverse_of => :traits

    acts_as_nested_set

    after_create :add_columns
    after_save :change_columns
    after_destroy :remove_columns

    # reset column information on the variety when necessary
    after_save :reset_columns
    after_destroy :reset_columns

    validates :name,
              :presence => true,
              :uniqueness => { :scope => 'variety_id' }

    unloadable

    def qualified_name
      [parent.try(:qualified_name), name].compact.join('_').attrify
    end

    def adapt(klass)
      # nothing to do here yet
    end

    def column_name
      qualified_name
    end

    def method_name
      column_name
    end

    def column_type
      :string
    end
    
    def arel_column
      variety.klass.arel_table[method_name]
    end
    
    def to_conditions(params)
      [ (Habanero::Condition.new(:predicate => condition_predicate, :value => condition_value(params), :trait => self) unless condition_value(params).blank?) ]
    end
    
    def condition_predicate
      Habanero::Category.find_by_abbreviation('matches')
    end
    
    def condition_value(params)
      params[method_name]
    end

    def apply_inclusions(grader_chain)
      grader_chain
    end
    
    def maybe_with_html_disabled(context)
      self # nothing to do at the abtract level
    end
    
    protected

    def add_columns
      unless column_exists?(column_name)
        add_column column_name, column_type
      end

      adapt(variety.klass) if variety.germinated?
    end

    def change_columns
      if name_was and name_changed?
        rename_column(name_was.attrify, column_name)
      end
    end

    def remove_columns
      remove_column(column_name)
    end

    def reset_columns
      variety.klass.reset_column_information unless parent
    end

    [:add_column, :remove_column, :rename_column, :'column_exists?',
     :add_index, :remove_index, :rename_index, :'index_exists?'].each do |msg|
      class_eval <<-RUBY_EVAL
        def #{msg}(*args)
          args.unshift(variety.table_name)
          connection.send(:#{msg}, *args)
        end
      RUBY_EVAL
    end
  end
end

Green.germinate_model('Habanero', 'Trait')

Habanero::Trait.class_eval { include Habanero::TraitGraft }