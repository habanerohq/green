module Habanero
  class Brand < ActiveRecord::Base
  end
end

Habanero::Brand.class_eval { include Habanero::BrandGraft }

if Habanero::Sorbet.table_exists?
  Habanero::Sorbet.branded('Habanero').where(:name => 'Brand').first.try(:adapt)
  Habanero::Brand.class_attribute :_sorbet
  Habanero::Brand._sorbet = Habanero::Sorbet.branded('Habanero').where(:name => 'Brand').first
end
