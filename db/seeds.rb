# Phase 2 - Sites, Sections & Pages

namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

site = Habanero::Sorbet.create!(:name => 'Site', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => site)

section = Habanero::Sorbet.create!(:name => 'Section', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => section)
Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => section)

Habanero::RelationIngredient.create!(
  :name => 'Site Sections',
  :sorbet => site,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :sorbet => site),
    Habanero::AssociationIngredient.new(:name => 'Site', :relation => 'belongs_to', :sorbet => section),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Template Sections',
  :sorbet => section,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :sorbet => section),
    Habanero::AssociationIngredient.new(:name => 'Template', :relation => 'belongs_to', :sorbet => section),
  ]
)

page = Habanero::Sorbet.create!(:name => 'Page', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => page)

l = Habanero::Sorbet.create!(:name => 'Layout', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => l)

Habanero::RelationIngredient.create!(
  :name => 'Section Pages',
  :sorbet => section,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :sorbet => section),
    Habanero::AssociationIngredient.new(:name => 'Section', :relation => 'belongs_to', :sorbet => page),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Layout Pages',
  :sorbet => l,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :sorbet => l),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :sorbet => page),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Template Pages',
  :sorbet => page,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :sorbet => page),
    Habanero::AssociationIngredient.new(:name => 'Template', :relation => 'belongs_to', :sorbet => page),
  ]
)

# Phase 1 - Namespace, Sorbet & Ingredient Definition
=begin
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
Habanero::Sorbet.create!(:name => 'NestIngredient', :namespace => namespace, :parent => ingredient)

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
=end