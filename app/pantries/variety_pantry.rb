class VarietyPantry < Pantry::Base  
  def define_stacks
    refers_to 'Habanero::Category', :id_value_methods => [:name, :parent]
    
    can_stack 'Habanero::Brand', :scope => {:where => {:name => ['Habanero', 'ActiveRecord']}}
    can_stack 'Habanero::Variety', 
      :id_value_methods => [:name, :brand], 
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => ['Habanero', 'ActiveRecord']}}
      }
    
    [
      'Habanero::StringTrait', 
      'Habanero::TextTrait', 
      'Habanero::BlobTrait', 
      'Habanero::TrueFalseTrait', 
      'Habanero::IntegerTrait', 
      'Habanero::DecimalTrait', 
      'Habanero::NumberTrait', 
      'Habanero::PercentageTrait', 
      'Habanero::CurrencyTrait', 
      'Habanero::DateTrait', 
      'Habanero::DateTimeTrait', 
      'Habanero::TimeTrait', 
      'Habanero::NameTrait', 
      'Habanero::RangeTrait', 
      'Habanero::NestTrait', 
      'Habanero::RelationTrait', 
      'Habanero::AssociationTrait', 
      'Habanero::SlugTrait',
      'Habanero::CategoryTrait',
      'Habanero::SignpostTrait'
    ].
    each do |i| 
      can_stack i, 
      :id_value_methods => [:name, :variety, :parent],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => ['Habanero', 'ActiveRecord']}}
      }
    end
  end
end