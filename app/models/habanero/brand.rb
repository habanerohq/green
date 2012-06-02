module Habanero
  class Brand < ActiveRecord::Base
    include Habanero::Graft
  end
end

Habanero::Brand.class_eval { include Habanero::BrandGraft }

Green.germinate_model('Habanero', 'Brand')