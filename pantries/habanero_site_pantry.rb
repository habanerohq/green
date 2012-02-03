class HabaneroSitePantry < Pantry::Base
  
  def initialize
    refers_to Habanero::Namespace
    refers_to Habanero::Sorbet, :id_value_methods => [:name, :namespace]

    can_stack Habanero::Site
    can_stack Habanero::Section, :id_value_methods => [:name, :site]
    can_stack Habanero::Page, :id_value_methods => [:name, :section]
  end
  
end