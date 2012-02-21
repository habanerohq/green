require 'habanero'
require 'habanero/autoload'

# set the default form builder
Sorbet2::Application.config.action_view.default_form_builder = Habanero::IngredientsFormBuilder
