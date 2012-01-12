# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

namespace = Habanero::Namespace.create(:name => 'Habanero')

Habanero::Sorbet.create(
  :namespace => namespace,
  :name => 'Namespace'
)

Habanero::Sorbet.create(
  :namespace => namespace,
  :name => 'Sorbet'
)

Habanero::Sorbet.create(
  :namespace => namespace,
  :name => 'Ingredient'
)