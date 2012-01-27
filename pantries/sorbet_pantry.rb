class SorbetPantry < Pantry::Base
  
  def initialize
    can_stack Habanero::Namespace
    can_stack Habanero::Sorbet, :id_value_methods => [:name, :namespace]
    can_stack Habanero::Ingredient, :id_value_methods => [:name, :sorbet]
  end
  
end