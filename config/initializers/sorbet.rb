require 'habanero'
require 'habanero/autoload'
#require 'habanero/observer'

#ActionView::Base.default_form_builder = Habanero::IngredientsFormBuilder

if Habanero::Variety.table_exists?
  ActiveRecord::Base.observers = :'habanero/observer'
  ActiveRecord::Base.instantiate_observers

  # ignore variety-generated database tables when dumping schema
  ActiveRecord::SchemaDumper.ignore_tables = Habanero::Variety.all.map(&:table_name) - ['habanero_varieties', 'habanero_ingredients', 'habanero_brands']
end
