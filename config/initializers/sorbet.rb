require 'habanero'
require 'habanero/autoload'

ActionView::Base.default_form_builder = Habanero::IngredientsFormBuilder
