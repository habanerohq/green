# todo: this should be done via #hook! or similar
ActiveSupport::Dependencies.send :include, Habanero::Autoload

# set the default form builder
Sorbet2::Application.config.action_view.default_form_builder = Habanero::IngredientsFormBuilder