class SitePantry < Pantry::Base
  def site_name
    #hook method for subclasses
  end
  
  def define_stacks
    refers_to 'Habanero::Brand'

    refers_to 'Habanero::Garden', 
      :id_value_methods => [:name, :brand, :parent]

    refers_to 'Habanero::Theme', 
      :id_value_methods => [:name, :brand, :parent]

    refers_to 'Habanero::Scene', 
      :id_value_methods => [:name, :garden]

    can_stack 'Habanero::Site', :scope => {:where => {:name => site_name}}
    
    can_stack 'Habanero::GardenPlacement', 
      :id_value_methods => [:site, :garden],
      :scope => {
        :includes => :site,
        :where => {:habanero_sites => {:name => site_name}}
      }
  end
end
