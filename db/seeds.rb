# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

active_record = Habanero::Sorbet.create!(
  :namespace => Habanero::Namespace.new(:name => 'ActiveRecord'),
  :name => 'Base'
)

namespace = Habanero::Namespace.create!(:name => 'Habanero')

# Habanero::Ingredient
ingredient = Habanero::Sorbet.create!(:name => 'Ingredient', :namespace => namespace, :parent => active_record)

# Habanero::StringIngredient
Habanero::Sorbet.create!(:name => 'StringIngredient', :namespace => namespace, :parent => ingredient)

# need to define all ingredients for Habanero::Ingredient before this point
ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Name')
ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Type')
ingredient.save!

# Habanero::TrueFalseIngredient
Habanero::Sorbet.create!(
  :name => 'TrueFalseIngredient',
  :namespace => namespace,
  :parent => ingredient
)

# Habanero::RelationIngredient
Habanero::Sorbet.create!(
  :name => 'RelationIngredient',
  :namespace => namespace,
  :parent => ingredient,
  
  :ingredients => [
    Habanero::TrueFalseIngredient.new(:name => 'Ordered')
  ]
)

# Habanero::AssociationIngredient
Habanero::Sorbet.create!(
  :name => 'AssociationIngredient',
  :namespace => namespace,
  :parent => ingredient,
  
  :ingredients => [
    Habanero::StringIngredient.new(:name => 'Relation')
  ]
)

Habanero::Sorbet.create!( # Habanero::Namespace
  :namespace => namespace,
  :name => 'Namespace',
  :parent => active_record,
  :ingredients => [
    Habanero::StringIngredient.new(:name => 'Name')
  ]
)

Habanero::Sorbet.create! do |s| # Habanero::Sorbet
  s.name = 'Sorbet'
  s.namespace = namespace
  s.parent = active_record
  
  s.ingredients << Habanero::StringIngredient.new(:name => 'Name')
  s.ingredients << Habanero::RelationIngredient.new(
    :name => 'Sorbet Ingredients',
    :children => [
      Habanero::AssociationIngredient.new(:name => 'Ingredients', :relation => 'has_many', :sorbet => s),
      Habanero::AssociationIngredient.new(:name => 'Sorbet', :relation => 'belongs_to', :sorbet => ingredient),
    ]
  )
end

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

=begin

children = Habanero::Sorbet.create!(
  :namespace => Habanero::Namespace.new(:name => 'Zomg'),
  :name => 'Children',
  :parent => active_record
)

Habanero::Sorbet.create!(
  :namespace => Habanero::Namespace.new(:name => 'Zomg'),
  :name => 'Parent',
  :parent => active_record,
  :ingredients => [
    Habanero::RelationIngredient.new(:name => 'Children', :relation => 'has_many', :sorbet => children)
  ]
)

=end