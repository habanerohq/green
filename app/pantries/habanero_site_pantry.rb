class HabaneroSitePantry < Pantry::Base
  
  def define_stacks
    # ugly hack to ensure that descendants reports all the expected subclasses
    if i = Habanero::Variety.find_by_name('Trait')
      i.descendants.map(&:klass)
    end
    if i = Habanero::Variety.find_by_name('Feature')
      i.descendants.map(&:klass)
    end
    
    refers_to 'Habanero::Brand'
    refers_to 'Habanero::Variety', :id_value_methods => [:name, :brand]
    refers_to 'Habanero::Trait', :id_value_methods => [:name, :variety]

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
    can_stack 'Habanero::Garden', 
      :id_value_methods => [:name, :site, :parent],
      :scope => {
        :includes => :site,
        :where => {:habanero_sites => {:name => 'Habanero'}}
      }      
    can_stack 'Habanero::Page', 
      :id_value_methods => [:name, :garden],
      :scope => {
        :includes =>  {:garden => :site},
        :where => {:habanero_sites => {:name => 'Habanero'}}
      }      
    can_stack 'Habanero::Sieve', 
      :id_value_methods => [:name, :variety],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => 'Habanero'}}
      }
      
    can_stack 'Habanero::SieveTrait', 
      :id_value_methods => [:sieve, :trait],
      :scope => {
        :includes => {:sieve => {:variety => :brand}},
        :where => {:habanero_brands => {:name => 'Habanero'}}
      }
    
    can_stack 'Habanero::Grader', 
      :id_value_methods => [:name, :variety],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => 'Habanero'}}
      }
    can_stack 'Habanero::Condition', 
      :id_value_methods => [:grader, :trait]

    can_stack 'Habanero::Feature',
      :id_value_methods => [:name, :brand],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => 'Habanero'}}
      }
    can_stack 'Habanero::FeaturePlacement', 
      :id_value_methods => [:template, :page, :feature, :region],
      :scope => {
        :includes => {:feature => :brand},
        :where => {:habanero_brands => {:name => 'Habanero'}}
      }

    can_stack 'Habanero::Category', 
      :id_value_methods => [:name, :parent]
  end
end






