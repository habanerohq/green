module Habanero
  class Brand < ActiveRecord::Base
  end
end

Habanero::Brand.class_eval { include Habanero::BrandGraft }

if Habanero::Variety.table_exists?
  Habanero::Variety.branded('Habanero').where(:name => 'Brand').first.try(:adapt)
  Habanero::Brand.class_attribute :_variety
  Habanero::Brand._variety = Habanero::Variety.branded('Habanero').where(:name => 'Brand').first
end