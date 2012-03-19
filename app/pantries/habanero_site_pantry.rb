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

    can_stack 'Habanero::Layout', :scope => {:where => {:name => ['Habanero', 'Kitchen']}}
    can_stack 'Habanero::LayoutRow', 
      :id_value_methods => [:name, :layout], 
      :scope => {
        :includes => :layout,
        :where => {:habanero_layouts => {:name => ['Habanero', 'ActiveRecord']}}
      }
    can_stack 'Habanero::Region', 
      :id_value_methods => [:name, :layout, :row],
      :scope => {
        :includes => :layout,
        :where => {:habanero_layouts => {:name => ['Habanero', 'ActiveRecord']}}
      }

    can_stack 'Habanero::Site', :scope => {:where => {:name => 'Habanero'}}
    can_stack 'Habanero::Section', 
      :id_value_methods => [:name, :site, :parent],
      :scope => {
        :includes => :site,
        :where => {:habanero_sites => {:name => 'Habanero'}}
      }      
    can_stack 'Habanero::Page', 
      :id_value_methods => [:name, :section],
      :scope => {
        :includes =>  {:section => :site},
        :where => {:habanero_sites => {:name => 'Habanero'}}
      }      
    can_stack 'Habanero::Mask', 
      :id_value_methods => [:name, :sorbet],
      :scope => {
        :includes => {:sorbet => :namespace},
        :where => {:habanero_namespaces => {:name => 'Habanero'}}
      }
      
    can_stack 'Habanero::MaskIngredient', 
      :id_value_methods => [:mask, :ingredient],
      :scope => {
        :includes => {:mask => {:sorbet => :namespace}},
        :where => {:habanero_namespaces => {:name => 'Habanero'}}
      }
    
    can_stack 'Habanero::Query', 
      :id_value_methods => [:name, :sorbet],
      :scope => {
        :includes => {:sorbet => :namespace},
        :where => {:habanero_namespaces => {:name => 'Habanero'}}
      }
    can_stack 'Habanero::Condition', 
      :id_value_methods => [:query, :ingredient]

    can_stack 'Habanero::Scoop',
      :id_value_methods => [:name, :namespace],
      :scope => {
        :includes => :namespace,
        :where => {:habanero_namespaces => {:name => 'Habanero'}}
      }
    can_stack 'Habanero::ScoopPlacement', 
      :id_value_methods => [:template, :page, :scoop, :region],
      :scope => {
        :includes => {:scoop => :namespace},
        :where => {:habanero_namespaces => {:name => 'Habanero'}}
      }

    can_stack 'Habanero::Category', 
      :id_value_methods => [:name, :parent]
  end
end






