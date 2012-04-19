class SorbetPantry < Pantry::Base
  
  def define_stacks
    can_stack 'Habanero::Brand', :scope => {:where => {:name => ['Habanero', 'ActiveRecord']}}
    can_stack 'Habanero::Sorbet', 
      :id_value_methods => [:name, :brand], 
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => ['Habanero', 'ActiveRecord']}}
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
        :where => {:habanero_brands => {:name => ['Habanero', 'ActiveRecord']}}
      }
    end
  end

end