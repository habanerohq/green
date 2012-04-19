class InspiritivePantry < Pantry::Base
  
  def define_stacks
    can_stack 'Habanero::Brand', :scope => {:where => {:name => 'Inspiritive'}}
    can_stack 'Habanero::Sorbet', 
      :id_value_methods => [:name, :brand], 
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => 'Inspiritive'}}
      }
    
    [
      'Habanero::StringIngredient', 
      'Habanero::TextIngredient', 
      'Habanero::BlobIngredient', 
      'Habanero::TrueFalseIngredient', 
      'Habanero::IntegerIngredient', 
      'Habanero::DecimalIngredient', 
      'Habanero::NumberIngredient', 
      'Habanero::PercentageIngredient', 
      'Habanero::CurrencyIngredient', 
      'Habanero::DateIngredient', 
      'Habanero::DateTimeIngredient', 
      'Habanero::TimeIngredient', 
      'Habanero::NameIngredient', 
      'Habanero::RangeIngredient', 
      'Habanero::NestIngredient', 
      'Habanero::RelationIngredient', 
      'Habanero::AssociationIngredient', 
      'Habanero::SlugIngredient',
      'Habanero::CategoryIngredient',
      'Habanero::RouteIngredient'
    ].
    each do |i| 
      can_stack i, 
      :id_value_methods => [:name, :sorbet, :parent],
      :scope => {
        :includes => {:sorbet => :brand},
        :where => {:habanero_brands => {:name => 'Inspiritive'}}
      }
    end
    
    can_stack 'Habanero::Category', 
      :id_value_methods => [:name, :parent]
  end
end