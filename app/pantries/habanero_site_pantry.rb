class HabaneroSitePantry < Pantry::Base
  
  def define_stacks
    # ugly hack to ensure that descendants reports all the expected subclasses
    if i = Habanero::Sorbet.find_by_name('Ingredient')
      i.descendants.map(&:klass)
    end
    if i = Habanero::Sorbet.find_by_name('Scoop')
      i.descendants.map(&:klass)
    end
    
    refers_to 'Habanero::Namespace'
    refers_to 'Habanero::Sorbet', :id_value_methods => [:name, :namespace]
    refers_to 'Habanero::Ingredient', :id_value_methods => [:name, :sorbet]

    can_stack 'Habanero::Layout'
    can_stack 'Habanero::LayoutRow', :id_value_methods => [:name, :layout]
    can_stack 'Habanero::Region', :id_value_methods => [:name, :layout, :row]

    can_stack 'Habanero::Site'
    can_stack 'Habanero::Section', :id_value_methods => [:name, :site, :parent]
    can_stack 'Habanero::Page', :id_value_methods => [:name, :section]
    
    can_stack 'Habanero::Mask', :id_value_methods => [:name, :sorbet]
    can_stack 'Habanero::MaskIngredient', :id_value_methods => [:mask, :ingredient]

    can_stack 'Habanero::Scoop'
    can_stack 'Habanero::ScoopPlacement', :id_value_methods => [:template, :page, :scoop, :region]
  end
  
end






