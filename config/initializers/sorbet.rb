require 'habanero'
require 'habanero/autoload'
#require 'habanero/observer'

#ActionView::Base.default_form_builder = Habanero::IngredientsFormBuilder

if Habanero::Sorbet.table_exists?
  ActiveRecord::Base.observers = :'habanero/observer'
  ActiveRecord::Base.instantiate_observers

  # ignore sorbet-generated database tables when dumping schema
  ActiveRecord::SchemaDumper.ignore_tables = Habanero::Sorbet.all.map(&:table_name) - ['habanero_sorbets', 'habanero_ingredients', 'habanero_brands']
end
