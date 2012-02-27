# Phase 31 - Build one kitchen per tree

kit = Habanero::Section.find_by_name('Kitchens')
kit_layout = Habanero::Layout.find_by_name('Kitchen')

layout_page = kit.pages.first
layout_page.route = '/layouts'
layout_page.save!

site_page = Habanero::Page.create!(:name => 'Site Kitchen', :section => kit, :target => Habanero::Sorbet.find_by_name('Site'), :route => '/sites', :layout => kit_layout)
sorbet_page = Habanero::Page.create!(:name => 'Sorbet Kitchen', :section => kit, :target => Habanero::Sorbet.find_by_name('Sorbet'), :route => '/sorbets', :layout => kit_layout)
scoop_page = Habanero::Page.create!(:name => 'Scoop Kitchen', :section => kit, :target => Habanero::Sorbet.find_by_name('Scoop'), :route => '/scoops', :layout => kit_layout)
category_page = Habanero::Page.create!(:name => 'Category Kitchen', :section => kit, :target => Habanero::Sorbet.find_by_name('Category'), :route => '/categories', :layout => kit_layout)

placements = layout_page.placements

placements[1].page = site_page
placements[2].page = sorbet_page
placements[3].page = scoop_page
placements[4].page = category_page

left = kit_layout.regions.find_by_name('Left')
placements[2].region = left
placements[3].region = left
placements[4].region = left

placements.each { |p| p.save!}

# Phase 30 - More trees in the kitchen
=begin
# build the masks
site = Habanero::Sorbet.find_by_name('Site')
site_mask = Habanero::Mask.create!(:name => 'Site Tree Mask', :sorbet => site)
site_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => site.ingredients.find_by_name('Sections'))
site_mask.save!

section = Habanero::Sorbet.find_by_name('Section')
section_mask = Habanero::Mask.create!(:name => 'Section Tree Mask', :sorbet => section, :parent => site_mask)
section_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => section.ingredients.find_by_name('Pages'))
section_mask.save!

page = Habanero::Sorbet.find_by_name('Page')
page_mask = Habanero::Mask.create!(:name => 'Page Tree Mask', :sorbet => page, :parent => section_mask)
page_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => page.ingredients.find_by_name('Placements'))
page_mask.save!

scoop = Habanero::Sorbet.find_by_name('Scoop')
scoop_mask = Habanero::Mask.create!(:name => 'Scoop Tree Mask', :sorbet => scoop)
scoop_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => scoop.ingredients.find_by_name('Placements'))
scoop_mask.save!

namespace = Habanero::Sorbet.find_by_name('Namespace')
namespace_mask = Habanero::Mask.create!(:name => 'Namespace Tree Mask', :sorbet => namespace)
namespace_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => namespace.ingredients.find_by_name('Sorbets'))
namespace_mask.save!

sorbet = Habanero::Sorbet.find_by_name('Sorbet')
sorbet_mask = Habanero::Mask.create!(:name => 'Sorbet Tree Mask', :sorbet => sorbet, :parent => namespace_mask)
sorbet_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Ingredients'))
sorbet_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Masks'))
sorbet_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Queries'))
sorbet_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Sections'))
sorbet_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Pages'))
sorbet_mask.save!

mask = Habanero::Sorbet.find_by_name('Mask')
mask_mask = Habanero::Mask.create!(:name => 'Mask Tree Mask', :sorbet => mask, :parent => sorbet_mask)
mask_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => mask.ingredients.find_by_name('Mask Ingredients'))
mask_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => mask.ingredients.find_by_name('Sorbet Scoops'))
mask_mask.save!

category = Habanero::Sorbet.find_by_name('Category')
category_mask = Habanero::Mask.create!(:name => 'Category Tree Mask', :sorbet => category)
category_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => category.ingredients.find_by_name('Ingredients'))
category_mask.save!

page = Habanero::Page.find_by_name('Layout Kitchen')

# build the scoops
site_scoop = Habanero::SorbetCollectionScoop.create!(:name => 'Site Tree', :mask => Habanero::Mask.find_by_name('Site Tree Mask'))
scoop_scoop = Habanero::SorbetCollectionScoop.create!(:name => 'Scoop Tree', :mask => Habanero::Mask.find_by_name('Scoop Tree Mask'))
sorbet_scoop = Habanero::SorbetCollectionScoop.create!(:name => 'Sorbet Tree', :mask => Habanero::Mask.find_by_name('Sorbet Tree Mask'))
category_scoop = Habanero::SorbetCollectionScoop.create!(:name => 'Category Tree', :mask => Habanero::Mask.find_by_name('Category Tree Mask'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => site_scoop, :region => page.layout.regions.find_by_name('Left'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => sorbet_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => category_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
=end
# Phase 29 - Create some Layout Masks for tree rendering
=begin
layout = Habanero::Sorbet.find_by_name('Layout')
l_mask = Habanero::Mask.create!(:name => 'Layout Tree Mask', :sorbet => layout)
l_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Rows'))
l_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Pages'))
l_mask.save!

row = Habanero::Sorbet.find_by_name('LayoutRow')
row_mask = Habanero::Mask.create!(:name => 'Layout Row Tree Mask', :sorbet => row, :parent => l_mask)
row_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Regions'))
row_mask.save!

region = Habanero::Sorbet.find_by_name('Region')
r_mask = Habanero::Mask.create!(:name => 'Region Tree Mask', :sorbet => region, :parent => row_mask)
r_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Placements'))
r_mask.save!
=end
# Phase 28 - queries on scoops
=begin
scoop = Habanero::Sorbet.find_by_name('Scoop')
query = Habanero::Sorbet.find_by_name('Query')

Habanero::RelationIngredient.create!(
  :name => 'Query Scoops',
  :sorbet => query,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Query', :relation => 'belongs_to', :sorbet => scoop),
    Habanero::AssociationIngredient.new(:name => 'Scoops', :relation => 'has_many', :sorbet => query)
  ]
)

# Phase 27 - queries
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

query = Habanero::Sorbet.create!(:name => 'Query', :parent => active_record, :namespace => namespace)
query.ingredients << Habanero::StringIngredient.new(:name => 'Name')

Habanero::RelationIngredient.create!(
  :name => 'Sorbet Queries',
  :sorbet => query,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sorbet', :relation => 'belongs_to', :sorbet => query),
    Habanero::AssociationIngredient.new(:name => 'Queries', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Sorbet'))
  ]
)

condition = Habanero::Sorbet.create!(:name => 'Condition', :parent => active_record, :namespace => namespace)
condition.ingredients << Habanero::StringIngredient.new(:name => 'Predicate') # todo: should not be a StringIngredient
condition.ingredients << Habanero::StringIngredient.new(:name => 'Value')

Habanero::RelationIngredient.create!(
  :name => 'Ingredient Conditions',
  :sorbet => condition,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredient', :relation => 'belongs_to', :sorbet => condition),
    Habanero::AssociationIngredient.new(:name => 'Conditions', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Ingredient'))
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Query Conditions',
  :sorbet => query,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Query', :relation => 'belongs_to', :sorbet => condition),
    Habanero::AssociationIngredient.new(:name => 'Conditions', :relation => 'has_many', :sorbet => query)
  ]
)
=end
# Phase 26 - add template back into Scoop
=begin
scoop = Habanero::Sorbet.find_by_name('Scoop')
Habanero::StringIngredient.create!(:name => 'Template', :sorbet => scoop)
=end
# Phase 26 - Fix region names 
=begin
layout = Habanero::Layout.find_by_name('Kitchen')

r = layout.regions.find_by_name('Right')
r.name = 'Left'
r.save!

body = layout.rows.find_by_name('Body')

Habanero::Region.create!(:name => 'Right', :span => 3, :layout => layout, :row => body)
=end
# Phase 25 - Start Layout Kitchen
=begin
layout = Habanero::Sorbet.find_by_name('Layout')
sorbet2 = Habanero::Section.find_by_name('Sorbet2')

kit_layout = Habanero::Layout.find_by_name('Kitchen')

# fix a naming error from last seed phase
r = kit_layout.regions.find_all_by_name('Left').last
r.name = 'Right'
r.save!

kit = Habanero::Section.create!(:name => 'Kitchens', :route => '/kitchen', :site => sorbet2.site, :parent => sorbet2)
page = Habanero::Page.create!(:name => 'Layout Kitchen', :section => kit, :target => layout, :route => '/layouts', :layout => kit_layout)

# build the scoops
scoop = Habanero::LayoutScoop.create!(:name => 'Layout')

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :region => kit_layout.regions.find_by_name('Content'), :template => 'layout')
=end
# Phase 24 - Create some Layout Masks
=begin
layout = Habanero::Sorbet.find_by_name('Layout')
mask = Habanero::Mask.create!(:name => 'Layout Mask', :sorbet => layout)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Template Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Fluid'))
mask.save!

row = Habanero::Sorbet.find_by_name('LayoutRow')
mask = Habanero::Mask.create!(:name => 'Layout Row Mask', :sorbet => row)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Layout'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Fluid'))
mask.save!

region = Habanero::Sorbet.find_by_name('Region')
mask = Habanero::Mask.create!(:name => 'Region Mask', :sorbet => region)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Layout'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Row'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Span'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Offset'))
mask.save!
=end
# Phase 23 - Define LayoutScoop
=begin
parent = Habanero::Sorbet.find_by_name('SorbetScoop')
namespace = Habanero::Namespace.find_by_name('Habanero')
Habanero::Sorbet.create!(:name => 'LayoutScoop', :namespace => namespace, :parent => parent)
=end
# Phase 22 - Build a fluid layout for "sorbet kitchens"
=begin
layout = Habanero::Layout.create!(:name => 'Kitchen', :fluid => true)

header = Habanero::LayoutRow.create!(:name => 'Header', :layout => layout, :fluid => true)
body = Habanero::LayoutRow.create!(:name => 'Body', :layout => layout, :fluid => true)
footer = Habanero::LayoutRow.create!(:name => 'Footer', :layout => layout)

Habanero::Region.create!(:name => 'Top', :span => 12, :layout => layout, :row => header)
Habanero::Region.create!(:name => 'Header', :span => 12, :layout => layout, :row => header)
Habanero::Region.create!(:name => 'Content Top', :span => 12, :layout => layout, :row => header)

Habanero::Region.create!(:name => 'Left', :span => 3, :layout => layout, :row => body)
Habanero::Region.create!(:name => 'Content', :span => 6, :layout => layout, :row => body)
Habanero::Region.create!(:name => 'Left', :span => 3, :layout => layout, :row => body)

Habanero::Region.create!(:name => 'Content Bottom', :span => 12, :layout => layout, :row => footer)
Habanero::Region.create!(:name => 'Footer', :span => 12, :layout => layout, :row => footer)
=end
# Phase 21 - Add a template name to Layout
=begin
layout = Habanero::Sorbet.find_by_name('Layout')
Habanero::StringIngredient.create!(:name => 'Template Name', :sorbet => layout)
=end
# Phase 20 - Define a layout with rows and regions
=begin
layout = Habanero::Layout.create!(:name => 'Habanero')

Habanero::Page.all.each do |p|
  p.layout = layout
  p.save!
end

header = Habanero::LayoutRow.create!(:name => 'Header', :layout => layout)
body = Habanero::LayoutRow.create!(:name => 'Body', :layout => layout)
footer = Habanero::LayoutRow.create!(:name => 'Footer', :layout => layout)

Habanero::Region.create!(:name => 'Top', :span => 12, :layout => layout, :row => header)
Habanero::Region.create!(:name => 'Header', :span => 12, :layout => layout, :row => header)
Habanero::Region.create!(:name => 'Content Top', :span => 12, :layout => layout, :row => header)

Habanero::Region.create!(:name => 'Sidebar', :span => 4, :layout => layout, :row => body)
Habanero::Region.create!(:name => 'Content', :span => 8, :layout => layout, :row => body)

Habanero::Region.create!(:name => 'Content Bottom', :span => 12, :layout => layout, :row => footer)
Habanero::Region.create!(:name => 'Footer', :span => 12, :layout => layout, :row => footer)
=end
# Phase 19 - Layout Rows
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

layout = Habanero::Sorbet.find_by_name('Layout')
Habanero::TrueFalseIngredient.create!(:name => 'Fluid', :sorbet => layout)

region = Habanero::Sorbet.find_by_name('Region')
Habanero::IntegerIngredient.create!(:name => 'Span', :sorbet => region)
Habanero::IntegerIngredient.create!(:name => 'Offset', :sorbet => region)

layout_row = Habanero::Sorbet.create!(:name => 'LayoutRow', :namespace => namespace, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :sorbet => layout_row)
Habanero::TrueFalseIngredient.create!(:name => 'Fluid', :sorbet => layout_row)

Habanero::RelationIngredient.create!(
  :name => 'Layout Rows',
  :sorbet => layout,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Rows', :relation => 'has_many', :sorbet => layout),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :sorbet => layout_row),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Row Regions',
  :sorbet => layout_row,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Regions', :relation => 'has_many', :sorbet => layout_row),
    Habanero::AssociationIngredient.new(:name => 'Row', :relation => 'belongs_to', :sorbet => region),
  ]
)
=end
# Phase 18 - Add Slug Ingredients
=begin
namespace = Habanero::Sorbet.find_by_name('Namespace')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => namespace, :target => namespace.ingredients.find_by_name('Name'))

sorbet = Habanero::Sorbet.find_by_name('Sorbet')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => sorbet, :target => sorbet.ingredients.find_by_name('Name'), :scope => sorbet.ingredients.find_by_name('Namespace'))

ingredient = Habanero::Sorbet.find_by_name('Ingredient')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => ingredient, :target => ingredient.ingredients.find_by_name('Name'), :scope => ingredient.ingredients.find_by_name('Sorbet'))

mask = Habanero::Sorbet.find_by_name('Mask')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => mask, :target => mask.ingredients.find_by_name('Name'), :scope => mask.ingredients.find_by_name('Sorbet'))

category = Habanero::Sorbet.find_by_name('Category')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => category, :target => category.ingredients.find_by_name('Name'))

site = Habanero::Sorbet.find_by_name('Site')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => site, :target => site.ingredients.find_by_name('Name'))

section = Habanero::Sorbet.find_by_name('Section')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => section, :target => section.ingredients.find_by_name('Name'), :scope => section.ingredients.find_by_name('Site'))

page = Habanero::Sorbet.find_by_name('Page')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => page, :target => page.ingredients.find_by_name('Name'), :scope => page.ingredients.find_by_name('Section'))

scoop = Habanero::Sorbet.find_by_name('Scoop')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => scoop, :target => scoop.ingredients.find_by_name('Name'))

layout = Habanero::Sorbet.find_by_name('Layout')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => layout, :target => layout.ingredients.find_by_name('Name'))

region = Habanero::Sorbet.find_by_name('Region')
Habanero::SlugIngredient.create!(:name => 'Slug', :sorbet => region, :target => region.ingredients.find_by_name('Name'), :scope => region.ingredients.find_by_name('Layout'))
=end
# Phase 17 - Invent Slug Ingredient
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')
assoc_ingredient = Habanero::Sorbet.find_by_name('AssociationIngredient')

s_ingredient = Habanero::Sorbet.create!(:name => 'SlugIngredient', :namespace => namespace, :parent => ingredient)

Habanero::RelationIngredient.create!(
  :name => 'Target Slug Ingredients',
  :sorbet => s_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Slug Ingredients', :relation => 'has_many', :sorbet => ingredient),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :sorbet => s_ingredient),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Scope Slug Ingredients',
  :sorbet => s_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Slug Ingredients', :relation => 'has_many', :sorbet => assoc_ingredient),
    Habanero::AssociationIngredient.new(:name => 'Scope', :relation => 'belongs_to', :sorbet => s_ingredient),
  ]
)
=end
# Phase 16 - Category Ingredient
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')
category = Habanero::Sorbet.find_by_name('Category')

c_ingredient = Habanero::Sorbet.create!(:name => 'CategoryIngredient', :namespace => namespace, :parent => ingredient)

Habanero::RelationIngredient.create!(
  :name => 'Category Ingredients',
  :sorbet => c_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredients', :relation => 'has_many', :sorbet => category),
    Habanero::AssociationIngredient.new(:name => 'Category', :relation => 'belongs_to', :sorbet => c_ingredient),
  ]
)
=end
# Phase 15 - Create category sorbet
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')
active_record = Habanero::Sorbet.find_by_name('Base')

c = Habanero::Sorbet.create!(:name => 'Category', :namespace => namespace, :parent => active_record)
nest = Habanero::NestIngredient.create!(:name => 'Nest', :sorbet => c)
name = Habanero::StringIngredient.create!(:name => 'Name', :sorbet => c)
abbrev = Habanero::StringIngredient.create!(:name => 'Abbreviation', :sorbet => c)
strat = Habanero::TextIngredient.create!(:name => 'Strategy', :sorbet => c)

mask = Habanero::Mask.create!(:name => 'Category Document Mask', :sorbet => c)
scoop = Habanero::DocumentationScoop.create!(:name => 'Category Document', :mask => mask)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => name)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => nest)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => abbrev)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => strat)

ref = Habanero::Section.find_by_name('Reference Manual')
content_page = Habanero::Page.create!(:name => 'Category Page', :section => ref, :route => '/ingredients/:id', :target => c)
edit_page = Habanero::Page.create!(:name => 'Category Edit Page', :section => ref, :route => '/ingredients/:id/edit', :target => c, :next_page => content_page)

Habanero::ScoopPlacement.create!(:page => edit_page, :scoop => scoop, :template => 'edit')
Habanero::ScoopPlacement.create!(:page => content_page, :scoop => scoop, :template => 'show')
=end
# Phase 14 - Create a sorbet edit page
=begin
ingredient = Habanero::Sorbet.find_by_name('Ingredient')
ref = Habanero::Section.find_by_name('Reference Manual')
next_page = Habanero::Page.find_by_name('Ingredient Page')
page = Habanero::Page.create!(:name => 'Ingredient Edit Page', :section => ref, :route => '/ingredients/:id/edit', :target => ingredient, :next_page => next_page)

scoop = Habanero::DocumentationScoop.find_by_name('Ingredient Document')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'edit')
=end
# Phase 13 - Create a sorbet edit page
=begin
ref = Habanero::Section.find_by_name('Reference Manual')
next_page = Habanero::Page.find_by_name('Sorbet Page')
page = Habanero::Page.create!(:name => 'Sorbet Edit Page', :section => ref, :route => '/sorbets/:id/edit', :next_page => next_page)

scoop = Habanero::DocumentationScoop.find_by_name('Sorbet Document')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'edit')
=end
# Phase 12 - Add a next page ingredient to pages, create a sorbet edit page
=begin
p_sorbet = Habanero::Sorbet.find_by_name('Page')

Habanero::RelationIngredient.create!(
  :name => 'Previous Next Pages',
  :sorbet => p_sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Previous Pages', :relation => 'has_many', :sorbet => p_sorbet),
    Habanero::AssociationIngredient.new(:name => 'Next Page', :relation => 'belongs_to', :sorbet => p_sorbet),
  ]
)
=end
# Phase 11 - Fix the ingredients documentation phase
=begin
ingredient = Habanero::Sorbet.find_by_name('Ingredient')
i_page = Habanero::Page.find_by_name('Ingredient Page')
i_page.target = ingredient
i_page.save!
=end
# Phase 10 - Add a target sorbet to page
=begin
page = Habanero::Sorbet.find_by_name('Page')
sorbet = Habanero::Sorbet.find_by_name('Sorbet')

Habanero::RelationIngredient.create!(
  :name => 'Target Pages',
  :sorbet => sorbet,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :sorbet => sorbet),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :sorbet => page),
  ]
)
=end
# Phase 9 - Invent collection scoops, reconstruct Scoop inheritance hierarchy
=begin
namespace = Habanero::Namespace.find_by_name('Habanero')

s = Habanero::Sorbet.find_by_name('Scoop')

sorbet_scoop = Habanero::Sorbet.create!(:name => 'SorbetScoop', :namespace => namespace, :parent => s)

# rename list scoop to collection scoop and make it a child of sorbet scoop
ls = Habanero::Sorbet.find_by_name('ListScoop')
ls.name = 'CollectionScoop'
ls.parent = sorbet_scoop
ls.save!

# move scoop mask to the level or sorbet scoop
Habanero::RelationIngredient.find_by_name('Mask Documentation Scoops').destroy

mask = Habanero::Sorbet.find_by_name('Mask')

Habanero::RelationIngredient.create!(
  :name => 'Mask Sorbet Scoops',
  :sorbet => mask,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sorbet Scoops', :relation => 'has_many', :sorbet => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :sorbet => sorbet_scoop),
  ]
)

# make documentation scoop a child of sorbet scoop
ds = Habanero::Sorbet.find_by_name('DocumentationScoop')
ds.parent = sorbet_scoop
ds.save!

# create a new type of scoop -- Document Collection Scoop -- and create some instances for placement
mask = Habanero::Mask.find_by_name('Sorbet Document Mask')
sorbet = Habanero::Sorbet.create!(:name => 'DocumentationCollectionScoop', :namespace => namespace, :parent => ls)

s_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Sorbet List', :mask => mask)
i_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Ingredient List', :mask => mask)

# adjust the placements
s_placement = Habanero::ScoopPlacement.find(1)
s_placement.scoop = s_scoop
s_placement.save!

i_placement = Habanero::ScoopPlacement.find(3)
i_placement.scoop = i_scoop
i_placement.save!
=end
# Phase 8 - start building habanero site sorbet2 doco section
=begin
sorbet = Habanero::Sorbet.find_by_name('Sorbet')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

# move template column from Scoop to ScoopPlacement so we can reuse a scoop and apply a different template when placed
#Habanero::Sorbet.find_by_name('Scoop').ingredients.find_by_name('Template').destroy

#placement = Habanero::Sorbet.find_by_name('ScoopPlacement')
#Habanero::StringIngredient.create!(:name => 'Template', :sorbet => placement)

#Habanero::Scoop.reset_column_information
#Habanero::ScoopPlacement.reset_column_information

# build the site, section and pages
site = Habanero::Site.create!(:name => 'Habanero')
sorbet2 = Habanero::Section.create!(:name => 'Sorbet2', :route => '/sorbet2', :site => site)
ref = Habanero::Section.create!(:name => 'Reference Manual', :route => '/reference', :site => site, :target => sorbet, :parent => sorbet2)
page = Habanero::Page.create!(:name => 'Sorbet Page', :section => ref, :route => '/sorbets/:id')
i_page = Habanero::Page.create!(:name => 'Ingredient Page', :section => ref, :route => '/ingredients/:id')

# build the scoops
mask = Habanero::Mask.create!(:name => 'Sorbet Document Mask', :sorbet => sorbet)
scoop = Habanero::DocumentationScoop.create!(:name => 'Sorbet Document', :mask => mask)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Namespace'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Sorbet Nest'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => sorbet.ingredients.find_by_name('Documentation'))
mask.save!

i_mask = Habanero::Mask.create!(:name => 'Ingredient Document Mask', :sorbet => ingredient)
i_scoop = Habanero::DocumentationScoop.create!(:name => 'Ingredient Document', :mask => i_mask)
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Name'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Type'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Documentation'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Derived'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Limit'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Precision'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Scale'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Default'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Nullable'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Sortable'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Sort Direction'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Ordered'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Relation'))
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Sorbet'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'show')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'show')
=end
# Phase 7 - add nests to Sorbets and Ingredients
=begin
sorbet = Habanero::Sorbet.find_by_name('Sorbet')
Habanero::NestIngredient.create!(:name => 'Sorbet Nest', :sorbet => sorbet)

ingredient = Habanero::Sorbet.find_by_name('Ingredient')
Habanero::NestIngredient.create!(:name => 'Ingredient Nest', :sorbet => ingredient)
=end
# Phase 6 - Documentation Ingredients, renaming MaskScoop to DocumentationScoop (which is the first specific use of Masks)
=begin
Habanero::Sorbet
Habanero::Ingredient
Habanero::Namespace

namespace = Habanero::Sorbet.find_by_name('Namespace')
sorbet = Habanero::Sorbet.find_by_name('Sorbet')
ingredient = Habanero::Sorbet.find_by_name('Ingredient')

Habanero::TextIngredient.create!(:name => 'Documentation', :sorbet => namespace)
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
=end
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
