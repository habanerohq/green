class SorbetPantry < Pantry::Base
  
  def initialize
    can_stack Habanero::Namespace
    can_stack Habanero::Sorbet, :id_value_methods => [:name, :namespace]
    
    # ugly hack to ensure that Habanero::Ingredient#descendants reports all the expected subclasses
    if i = Habanero::Sorbet.find_by_name('Ingredient')
      i.children.map(&:klass)
    end
    
    can_stack Habanero::Ingredient, :id_value_methods => [:name, :sorbet]
  end
  
end