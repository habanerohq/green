module Habanero
  class SearchFormBuilder < TraitsFormBuilder
    map_type :'habanero/association_trait', :to => SimpleForm::Inputs::StringInput

    def habanero_nest_trait(i)
      text_field :parent
    end

    def habanero_association_trait(i)
      text_field i.method_name if i.relation == 'belongs_to'
    end

    def default_trait_options(trait)
      super.merge :required => false
    end
  end
end
