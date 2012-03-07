require 'habanero'
require 'habanero/autoload'

ActionView::Base.default_form_builder = Habanero::IngredientsFormBuilder

if Habanero::Sorbet.table_exists?
  ActiveRecord::Base.observers = :'habanero/observer'
  ActiveRecord::Base.instantiate_observers
end
