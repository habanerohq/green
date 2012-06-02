require 'acts_as_list'
require 'awesome_nested_set'
require 'cells'
require 'friendly_id'
require 'kaminari'
require 'simple_form'
require 'acts-as-taggable-on'
require 'less-rails-bootstrap'
require 'devise'
require 'green/engine'

module Green  
  extend self
  
  def germinate_model(brand_name, model_name)
    if Habanero::Variety.table_exists? and v = Habanero::Variety.branded(brand_name).where(:name => model_name).first
      v.adapt
      klass = "#{brand_name}::#{model_name}".constantize
      klass.class_attribute :_variety
      klass._variety = v
    end
  end
end
