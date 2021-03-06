class BrandPantry < Pantry::Base
  def brand_name
    # hook method
  end
  
  def define_stacks
    can_stack 'Habanero::Brand', :scope => {:where => {:name => brand_name}}

    can_stack 'Habanero::Category', 
      :id_value_methods => [:name, :parent],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }

    can_stack 'Habanero::Variety', 
      :id_value_methods => [:name, :brand], 
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }
    
    [
      'Habanero::StringTrait', 
      'Habanero::TrueFalseTrait',
      'Habanero::IntegerTrait', 
      'Habanero::TextTrait', 
      'Habanero::BlobTrait', 
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
      'Habanero::TagTrait',
      'Habanero::CategoryTrait',
      'Habanero::SignpostTrait',
      'Habanero::FileTrait',
      'Tabasco::PictureTrait',
      'Habanero::ColorTrait',
      'Habanero::ScreenDimensionTrait'      
    ].
    each do |i| 
      can_stack i, 
      :id_value_methods => [:name, :variety, :parent],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }
    end

    can_stack 'Habanero::Layout',
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }
    
    can_stack 'Habanero::LayoutRow', 
      :id_value_methods => [:name, :layout], 
      :scope => {
        :includes => {:layout => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }

    can_stack 'Habanero::Bed', 
      :id_value_methods => [:name, :layout],
      :scope => {
        :includes => {:layout => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }

    can_stack 'Habanero::Theme', 
      :id_value_methods => [:name, :brand, :parent],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }      

    can_stack 'Habanero::Garden', 
      :id_value_methods => [:name, :brand, :parent],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }      
    can_stack 'Habanero::Scene', 
      :id_value_methods => [:name, :garden],
      :scope => {
        :includes => {:garden => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }      
    can_stack 'Habanero::Highlighter', 
      :id_value_methods => [:name, :variety],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }
      
    can_stack 'Habanero::TraitHighlight', 
      :id_value_methods => [:highlighter, :trait],
      :scope => {
        :includes => {:highlighter => {:variety => :brand}},
        :where => {:habanero_brands => {:name => brand_name}}
      }
    
    can_stack 'Habanero::Grader', 
      :id_value_methods => [:name, :variety],
      :scope => {
        :includes => {:variety => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }
    can_stack 'Habanero::Condition', 
      :id_value_methods => [:grader, :trait],
      :scope => {
        :includes => {:grader => {:variety => :brand}},
        :where => {:habanero_brands => {:name => brand_name}}
      }

    can_stack 'Tabasco::Gallery',
      :id_value_methods => [:name, :brand],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }
    can_stack 'Tabasco::Picture', 
      :id_value_methods => [:name, :gallery], 
      :scope => {
        :includes => {:gallery => :brand},
        :where => {:habanero_brands => {:name => brand_name}}
      }

    can_stack 'Habanero::Feature',
      :id_value_methods => [:name, :brand],
      :scope => {
        :includes => :brand,
        :where => {:habanero_brands => {:name => brand_name}}
      }
    can_stack 'Habanero::FeaturePlacement', 
      :id_value_methods => [:template, :scene, :feature, :bed],
      :scope => {
        :includes => {:scene => {:garden => :brand}},
        :where => {:habanero_brands => {:name => brand_name}}
      }
  end
end