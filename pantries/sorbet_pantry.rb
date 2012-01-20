class SorbetPantry < Pantry::Base
  can_stack Habanero::Namespace
  can_stack Habanero::Sorbet
  can_stack Habanero::Ingredient
end