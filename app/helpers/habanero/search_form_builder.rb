module Habanero
  class SearchFormBuilder < IngredientsFormBuilder

    def habanero_nest_ingredient(i)
      text_field :parent
    end

    def habanero_association_ingredient(i)
      text_field i.method_name if i.relation == 'belongs_to'
    end

  end
end
