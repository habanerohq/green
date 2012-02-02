# Phase 6 - Documentation Ingredients, renaming MaskScoop to DocumentationScoop (which is the first specific use of Masks)

Habanero::Sorbet
Habanero::Ingredient
Habanero::Namespace

sorbet = Habanero::Sorbet.find_by_name('Sorbet')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

Habanero::TextIngredient.create!(:name => 'Documentation', :sorbet => sorbet)
Habanero::TextIngredient.create!(:name => 'Documentation', :sorbet => ingredient)

s = Habanero::Sorbet.find_by_name('MaskScoop')
s.name = 'DocumentationScoop'
s.save!

r = Habanero::RelationIngredient.find_by_name('Mask Mask Scoops')
r.name = 'Mask Documentation Scoops'
r.save!

a = Habanero::AssociationIngredient.find_by_name('Mask Scoops')
a.name = 'Documentation Scoop'
a.save!

# Phase 5 - Routes
=begin
Habanero::Sorbet
Habanero::Ingredient
Habanero::Namespace

namespace = Habanero::Namespace.find_by_name('Habanero')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

route = Habanero::Sorbet.create!(:name => 'RouteIngredient', :namespace => namespace, :parent => ingredient)

page = Habanero::Sorbet.find_by_name('Page')
page.ingredients << Habanero::RouteIngredient.new(:name => 'Route')

section = Habanero::Sorbet.find_by_name('Section')
section.ingredients << Habanero::RouteIngredient.new(:name => 'Route')

site = Habanero::Sorbet.find_by_name('Site')
site.ingredients << Habanero::StringIngredient.new(:name => 'Host')
=end
# Phase 4 - Composite Scoops & Masks Scoop
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

scoop = Habanero::Sorbet.find_by_name('Scoop')
Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => scoop)

section = Habanero::Sorbet.find_by_name('Section')
sorbet = Habanero::Sorbet.find_by_name('Sorbet')

Habanero::RelationIngredient.create!(
  :name => 'Target Sections',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :sorbet => section),
  ]
)

mask = Habanero::Sorbet.create!(:name => 'Mask', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => mask)
Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => mask)

Habanero::RelationIngredient.create!(
  :name => 'Sorbet Masks',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Masks', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Sorbet', :relation => 'belongs_to', :sorbet => mask),
  ]
)

mask_ingredient = Habanero::Sorbet.create!(:name => 'MaskIngredient', :namespace => namespace, :parent => active_record)
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Ingredients',
  :sorbet => mask,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :sorbet => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :sorbet => mask_ingredient),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Ingredient Mask Ingredients',
  :sorbet => ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :sorbet => ingredient),
    Habanero::AssociationIngredient.new(:name => 'Ingredient', :relation => 'belongs_to', :sorbet => mask_ingredient),
  ]
)

mask_scoop = Habanero::Sorbet.create!(:name => 'MaskScoop', :namespace => namespace, :parent => scoop)

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Scoops',
  :sorbet => mask,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Scoops', :relation => 'has_many', :sorbet => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :sorbet => mask_scoop),
  ]
)
=end
# Phase 3 - Basic Scoops, Placements & Regions
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

# Phase 4 - Composite Scoops & Masks Scoop
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

scoop = Habanero::Sorbet.find_by_name('Scoop')
Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => scoop)

section = Habanero::Sorbet.find_by_name('Section')
sorbet = Habanero::Sorbet.find_by_name('Sorbet')

Habanero::RelationIngredient.create!(
  :name => 'Target Sections',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :sorbet => section),
  ]
)

mask = Habanero::Sorbet.create!(:name => 'Mask', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => mask)
Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => mask)

Habanero::RelationIngredient.create!(
  :name => 'Sorbet Masks',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Masks', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Sorbet', :relation => 'belongs_to', :sorbet => mask),
  ]
)

mask_ingredient = Habanero::Sorbet.create!(:name => 'MaskIngredient', :namespace => namespace, :parent => active_record)
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Ingredients',
  :sorbet => mask,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :sorbet => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :sorbet => mask_ingredient),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Ingredient Mask Ingredients',
  :sorbet => ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :sorbet => ingredient),
    Habanero::AssociationIngredient.new(:name => 'Ingredient', :relation => 'belongs_to', :sorbet => mask_ingredient),
  ]
)

mask_scoop = Habanero::Sorbet.create!(:name => 'MaskScoop', :namespace => namespace, :parent => scoop)

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Scoops',
  :sorbet => mask,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Scoops', :relation => 'has_many', :sorbet => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :sorbet => mask_scoop),
  ]
)
=end
# Phase 3 - Basic Scoops, Placements & Regions
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

page = Habanero::Sorbet.find_by_name('Page')

scoop = Habanero::Sorbet.create!(:name => 'Scoop', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Type', :sorbet => scoop)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => scoop)
Habanero::StringIngredient.create!(:name => 'Title', :sorbet => scoop)
Habanero::TextIngredient.create!(:name => 'Body', :sorbet => scoop)
Habanero::StringIngredient.create!(:name => 'Body Format', :sorbet => scoop)
Habanero::StringIngredient.create!(:name => 'Template', :sorbet => scoop)

Habanero::Sorbet.create!(:name => 'ContentScoop', :namespace => namespace, :parent => scoop)

list_scoop = Habanero::Sorbet.create!(:name => 'ListScoop', :namespace => namespace, :parent => scoop)
Habanero::IntegerIngredient.create!(:name => 'Columns', :sorbet => list_scoop)

placement = Habanero::Sorbet.create!(:name => 'ScoopPlacement', :namespace => namespace, :parent => active_record)

Habanero::RelationIngredient.create!(
  :name => 'Scoop Placements',
  :sorbet => page,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :sorbet => page),
    Habanero::AssociationIngredient.new(:name => 'Page', :relation => 'belongs_to', :sorbet => placement),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Scoop Placements',
  :sorbet => scoop,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :sorbet => scoop),
    Habanero::AssociationIngredient.new(:name => 'Scoop', :relation => 'belongs_to', :sorbet => placement),
  ]
)

lay = Habanero::Sorbet.find_by_name('Layout')

region = Habanero::Sorbet.create!(:name => 'Region', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => region)

Habanero::RelationIngredient.create!(
  :name => 'Layout Regions',
  :sorbet => lay,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Regions', :relation => 'has_many', :sorbet => lay),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :sorbet => region),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Region Placements',
  :sorbet => region,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :sorbet => region),
    Habanero::AssociationIngredient.new(:name => 'Region', :relation => 'belongs_to', :sorbet => placement),
  ]
)
=end
# Phase 2 - Sites, Sections & Pages
=begin
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
=end
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
