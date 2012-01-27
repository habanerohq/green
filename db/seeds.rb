# Phase 1 - Namespace, Sorbet & Ingredient Definition

active_record = Habanero::Sorbet.create!(
  :namespace => Habanero::Namespace.new(:name => 'ActiveRecord'),
  :name => 'Base'
)

namespace = Habanero::Namespace.create!(:name => 'Habanero')

ingredient = Habanero::Sorbet.create!(:name => 'Ingredient', :namespace => namespace, :parent => active_record)

Habanero::Sorbet.create!(:name => 'StringIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'IntegerIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'TrueFalseIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'TextIngredient', :namespace => namespace, :parent => ingredient)

ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Name')
ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Type')
ingredient.ingredients << Habanero::TrueFalseIngredient.new(:name => 'Derived')
ingredient.ingredients << Habanero::IntegerIngredient.new(:name => 'Limit')
ingredient.ingredients << Habanero::IntegerIngredient.new(:name => 'Precision')
ingredient.ingredients << Habanero::IntegerIngredient.new(:name => 'Scale')
ingredient.ingredients << Habanero::IntegerIngredient.new(:name => 'Default')
ingredient.ingredients << Habanero::TrueFalseIngredient.new(:name => 'Nullable')
ingredient.ingredients << Habanero::TrueFalseIngredient.new(:name => 'Sortable')
ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Sort Direction')
ingredient.ingredients << Habanero::TrueFalseIngredient.new(:name => 'Ordered')
ingredient.ingredients << Habanero::StringIngredient.new(:name => 'Relation')
ingredient.save!

sorbet = Habanero::Sorbet.create!(:name => 'Sorbet', :namespace => namespace, :parent => active_record)
namespace_sorbet = Habanero::Sorbet.create!(:name => 'Namespace', :namespace => namespace, :parent => active_record)

Habanero::Sorbet.create!(:name => 'BlobIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'CurrencyIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'DateIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'DateTimeIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'DecimalIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'NumberIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'PercentageIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'TimeIngredient', :namespace => namespace, :parent => ingredient)

Habanero::Sorbet.create!(:name => 'RelationIngredient', :namespace => namespace, :parent => ingredient)
Habanero::Sorbet.create!(:name => 'AssociationIngredient', :namespace => namespace, :parent => ingredient)

Habanero::StringIngredient.create!(:name => 'Name', :sorbet => sorbet)
Habanero::RelationIngredient.create!(
  :name => 'Sorbet Ingredients',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredients', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Sorbet', :relation => 'belongs_to', :sorbet => ingredient),
  ]
)

Habanero::StringIngredient.create!(:name => 'Name', :sorbet => namespace_sorbet)
Habanero::RelationIngredient.create!(
  :name => 'Namespace Sorbets',
  :sorbet => namespace_sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sorbets', :relation => 'has_many', :sorbet => namespace_sorbet),
    Habanero::AssociationIngredient.new(:name => 'Namespace', :relation => 'belongs_to', :sorbet => sorbet),
  ]
)
