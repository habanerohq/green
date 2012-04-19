# Phase 38 - variety create page

kit = Habanero::Section.find_by_name('Kitchens')
kit_layout = Habanero::Layout.find_by_name('Kitchen')

create_page = Habanero::Page.create!(:name => 'Create Variety', :section => kit, :target => Habanero::Variety.find_by_name('Site'), :route => '/sites/:variety_type/new', :layout => kit_layout)

# reuse the variety scoop from the edit page
edit_page = Habanero::Page.find_by_name('Edit Variety')
edit_scoop = edit_page.placements.detect { |sp| sp.scoop.is_a?(Habanero::VarietyScoop) && sp.template == 'edit' }.scoop
Habanero::ScoopPlacement.create!(:page => create_page, :scoop => edit_scoop, :region => edit_page.layout.regions.find_by_name('Content'), :template => 'new')

# move it to the right position, otherwise routes don't work
show_page = Habanero::Page.find_by_name('Show Variety')
create_page.insert_at(show_page.section_position)

# Phase 37 - fix variety tree mask hierarchy
=begin
scoop = Habanero::Page.find_by_name('Variety Kitchen').placements.first.scoop
scoop.mask = Habanero::Mask.find_by_name('Brand Tree Mask')
scoop.save!
=end
# Phase 36 - link kitchen pages to show & edit pages
=begin
show_page = Habanero::Page.find_by_name('Show Variety')
Habanero::Page.find_by_name('Layout Kitchen').placements.first.scoop.update_attribute(:page_id, show_page.id)
Habanero::Page.find_by_name('Variety Kitchen').placements.first.scoop.update_attribute(:page_id, show_page.id)
Habanero::Page.find_by_name('Scoop Kitchen').placements.first.scoop.update_attribute(:page_id, show_page.id)
Habanero::Page.find_by_name('Category Kitchen').placements.first.scoop.update_attribute(:page_id, show_page.id)
=end
# Phase 35 - Make our Varieties use NameIngredient
=begin
Habanero::Ingredient.update_all("type = 'Habanero::NameIngredient'", "type = 'Habanero::StringIngredient' AND name = 'Name'")
=end
# Phase 34 - Fix NameIngredient
=begin
ingredient = Habanero::Variety.find_by_name('Ingredient')
brand = Habanero::Brand.find_by_name('Habanero')

name_ingredient = Habanero::Variety.create!(
  :name => 'NameIngredient',
  :parent => ingredient,
  :brand => brand
)

Habanero::StringIngredient.create!(:name => 'Format', :variety => name_ingredient)
=end
# Phase 33 - Build an edit page for varieties
=begin
kit = Habanero::Section.find_by_name('Kitchens')
kit_layout = Habanero::Layout.find_by_name('Kitchen')

edit_page = Habanero::Page.create!(:name => 'Edit Variety', :section => kit, :target => Habanero::Variety.find_by_name('Site'), :route => '/sites/:variety_type/:id/edit', :layout => kit_layout)
edit_scoop = Habanero::VarietyScoop.create!(:name => 'Edit Variety')

Habanero::ScoopPlacement.create!(:page => edit_page, :scoop => edit_scoop, :region => edit_page.layout.regions.find_by_name('Content'), :template => 'edit')

Habanero::Page.find_by_name('Show Variety').placements.first.scoop.update_attribute(:page_id, edit_page.id)
=end
# Phase 32a - Build a show page for varieties
=begin
kit = Habanero::Section.find_by_name('Kitchens')
kit_layout = Habanero::Layout.find_by_name('Kitchen')

show_page = Habanero::Page.create!(:name => 'Show Variety', :section => kit, :target => Habanero::Variety.find_by_name('Site'), :route => '/sites/:variety_type/:id', :layout => kit_layout)

show_scoop = Habanero::VarietyScoop.create!(:name => 'Show Variety')

Habanero::ScoopPlacement.create!(:page => show_page, :scoop => show_scoop, :region => show_page.layout.regions.find_by_name('Content'), :template => 'show')

Habanero::Page.find_by_name('Site Kitchen').placements.first.scoop.update_attribute(:page_id, show_page.id)
=end
# Phase 32 - VarietyScoops belong to a Page
=begin
scoop = Habanero::Variety.find_by_name('VarietyScoop')
page = Habanero::Variety.find_by_name('Page')

Habanero::RelationIngredient.create!(
  :name => 'Page VarietyScoops',
  :variety => scoop,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Page', :relation => 'belongs_to', :variety => scoop),
    Habanero::AssociationIngredient.new(:name => 'VarietyScoops', :relation => 'has_many', :variety => page)
  ]
)
=end

# Phase 31 - Build one kitchen per tree
=begin
kit = Habanero::Section.find_by_name('Kitchens')
kit_layout = Habanero::Layout.find_by_name('Kitchen')

layout_page = kit.pages.first
layout_page.route = '/layouts'
layout_page.save!

site_page = Habanero::Page.create!(:name => 'Site Kitchen', :section => kit, :target => Habanero::Variety.find_by_name('Site'), :route => '/sites', :layout => kit_layout)
variety_page = Habanero::Page.create!(:name => 'Variety Kitchen', :section => kit, :target => Habanero::Variety.find_by_name('Variety'), :route => '/varieties', :layout => kit_layout)
scoop_page = Habanero::Page.create!(:name => 'Scoop Kitchen', :section => kit, :target => Habanero::Variety.find_by_name('Scoop'), :route => '/scoops', :layout => kit_layout)
category_page = Habanero::Page.create!(:name => 'Category Kitchen', :section => kit, :target => Habanero::Variety.find_by_name('Category'), :route => '/categories', :layout => kit_layout)

placements = layout_page.placements

placements[1].page = site_page
placements[2].page = variety_page
placements[3].page = scoop_page
placements[4].page = category_page

left = kit_layout.regions.find_by_name('Left')
placements[2].region = left
placements[3].region = left
placements[4].region = left

placements.each { |p| p.save!}
=end
# Phase 30 - More trees in the kitchen
=begin
# build the masks
site = Habanero::Variety.find_by_name('Site')
site_mask = Habanero::Mask.create!(:name => 'Site Tree Mask', :variety => site)
site_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => site.ingredients.find_by_name('Sections'))
site_mask.save!

section = Habanero::Variety.find_by_name('Section')
section_mask = Habanero::Mask.create!(:name => 'Section Tree Mask', :variety => section, :parent => site_mask)
section_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => section.ingredients.find_by_name('Pages'))
section_mask.save!

page = Habanero::Variety.find_by_name('Page')
page_mask = Habanero::Mask.create!(:name => 'Page Tree Mask', :variety => page, :parent => section_mask)
page_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => page.ingredients.find_by_name('Placements'))
page_mask.save!

scoop = Habanero::Variety.find_by_name('Scoop')
scoop_mask = Habanero::Mask.create!(:name => 'Scoop Tree Mask', :variety => scoop)
scoop_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => scoop.ingredients.find_by_name('Placements'))
scoop_mask.save!

brand = Habanero::Variety.find_by_name('Brand')
brand_mask = Habanero::Mask.create!(:name => 'Brand Tree Mask', :variety => brand)
brand_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => brand.ingredients.find_by_name('Varieties'))
brand_mask.save!

variety = Habanero::Variety.find_by_name('Variety')
variety_mask = Habanero::Mask.create!(:name => 'Variety Tree Mask', :variety => variety, :parent => brand_mask)
variety_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Ingredients'))
variety_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Masks'))
variety_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Queries'))
variety_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Sections'))
variety_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Pages'))
variety_mask.save!

mask = Habanero::Variety.find_by_name('Mask')
mask_mask = Habanero::Mask.create!(:name => 'Mask Tree Mask', :variety => mask, :parent => variety_mask)
mask_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => mask.ingredients.find_by_name('Mask Ingredients'))
mask_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => mask.ingredients.find_by_name('Variety Scoops'))
mask_mask.save!

category = Habanero::Variety.find_by_name('Category')
category_mask = Habanero::Mask.create!(:name => 'Category Tree Mask', :variety => category)
category_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => category.ingredients.find_by_name('Ingredients'))
category_mask.save!

page = Habanero::Page.find_by_name('Layout Kitchen')

# build the scoops
site_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Site Tree', :mask => Habanero::Mask.find_by_name('Site Tree Mask'))
scoop_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Scoop Tree', :mask => Habanero::Mask.find_by_name('Scoop Tree Mask'))
variety_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Variety Tree', :mask => Habanero::Mask.find_by_name('Variety Tree Mask'))
category_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Category Tree', :mask => Habanero::Mask.find_by_name('Category Tree Mask'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => site_scoop, :region => page.layout.regions.find_by_name('Left'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => variety_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => category_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
=end
# Phase 29 - Create some Layout Masks for tree rendering
=begin
layout = Habanero::Variety.find_by_name('Layout')
l_mask = Habanero::Mask.create!(:name => 'Layout Tree Mask', :variety => layout)
l_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Rows'))
l_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Pages'))
l_mask.save!

row = Habanero::Variety.find_by_name('LayoutRow')
row_mask = Habanero::Mask.create!(:name => 'Layout Row Tree Mask', :variety => row, :parent => l_mask)
row_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Regions'))
row_mask.save!

region = Habanero::Variety.find_by_name('Region')
r_mask = Habanero::Mask.create!(:name => 'Region Tree Mask', :variety => region, :parent => row_mask)
r_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Placements'))
r_mask.save!
=end
# Phase 28 - queries on scoops
=begin
scoop = Habanero::Variety.find_by_name('Scoop')
query = Habanero::Variety.find_by_name('Query')

Habanero::RelationIngredient.create!(
  :name => 'Query Scoops',
  :variety => query,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Query', :relation => 'belongs_to', :variety => scoop),
    Habanero::AssociationIngredient.new(:name => 'Scoops', :relation => 'has_many', :variety => query)
  ]
)

# Phase 27 - queries
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

query = Habanero::Variety.create!(:name => 'Query', :parent => active_record, :brand => brand)
query.ingredients << Habanero::StringIngredient.new(:name => 'Name')

Habanero::RelationIngredient.create!(
  :name => 'Variety Queries',
  :variety => query,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Variety', :relation => 'belongs_to', :variety => query),
    Habanero::AssociationIngredient.new(:name => 'Queries', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Variety'))
  ]
)

condition = Habanero::Variety.create!(:name => 'Condition', :parent => active_record, :brand => brand)
condition.ingredients << Habanero::StringIngredient.new(:name => 'Predicate') # todo: should not be a StringIngredient
condition.ingredients << Habanero::StringIngredient.new(:name => 'Value')

Habanero::RelationIngredient.create!(
  :name => 'Ingredient Conditions',
  :variety => condition,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredient', :relation => 'belongs_to', :variety => condition),
    Habanero::AssociationIngredient.new(:name => 'Conditions', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Ingredient'))
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Query Conditions',
  :variety => query,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Query', :relation => 'belongs_to', :variety => condition),
    Habanero::AssociationIngredient.new(:name => 'Conditions', :relation => 'has_many', :variety => query)
  ]
)
=end
# Phase 26 - add template back into Scoop
=begin
scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::StringIngredient.create!(:name => 'Template', :variety => scoop)
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
layout = Habanero::Variety.find_by_name('Layout')
variety2 = Habanero::Section.find_by_name('Sorbet2')

kit_layout = Habanero::Layout.find_by_name('Kitchen')

# fix a naming error from last seed phase
r = kit_layout.regions.find_all_by_name('Left').last
r.name = 'Right'
r.save!

kit = Habanero::Section.create!(:name => 'Kitchens', :route => '/kitchen', :site => variety2.site, :parent => variety2)
page = Habanero::Page.create!(:name => 'Layout Kitchen', :section => kit, :target => layout, :route => '/layouts', :layout => kit_layout)

# build the scoops
scoop = Habanero::LayoutScoop.create!(:name => 'Layout')

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :region => kit_layout.regions.find_by_name('Content'), :template => 'layout')
=end
# Phase 24 - Create some Layout Masks
=begin
layout = Habanero::Variety.find_by_name('Layout')
mask = Habanero::Mask.create!(:name => 'Layout Mask', :variety => layout)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Template Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => layout.ingredients.find_by_name('Fluid'))
mask.save!

row = Habanero::Variety.find_by_name('LayoutRow')
mask = Habanero::Mask.create!(:name => 'Layout Row Mask', :variety => row)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Layout'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => row.ingredients.find_by_name('Fluid'))
mask.save!

region = Habanero::Variety.find_by_name('Region')
mask = Habanero::Mask.create!(:name => 'Region Mask', :variety => region)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Layout'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Row'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Span'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => region.ingredients.find_by_name('Offset'))
mask.save!
=end
# Phase 23 - Define LayoutScoop
=begin
parent = Habanero::Variety.find_by_name('VarietyScoop')
brand = Habanero::Brand.find_by_name('Habanero')
Habanero::Variety.create!(:name => 'LayoutScoop', :brand => brand, :parent => parent)
=end
# Phase 22 - Build a fluid layout for "variety kitchens"
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
layout = Habanero::Variety.find_by_name('Layout')
Habanero::StringIngredient.create!(:name => 'Template Name', :variety => layout)
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
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

layout = Habanero::Variety.find_by_name('Layout')
Habanero::TrueFalseIngredient.create!(:name => 'Fluid', :variety => layout)

region = Habanero::Variety.find_by_name('Region')
Habanero::IntegerIngredient.create!(:name => 'Span', :variety => region)
Habanero::IntegerIngredient.create!(:name => 'Offset', :variety => region)

layout_row = Habanero::Variety.create!(:name => 'LayoutRow', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => layout_row)
Habanero::TrueFalseIngredient.create!(:name => 'Fluid', :variety => layout_row)

Habanero::RelationIngredient.create!(
  :name => 'Layout Rows',
  :variety => layout,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Rows', :relation => 'has_many', :variety => layout),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :variety => layout_row),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Row Regions',
  :variety => layout_row,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Regions', :relation => 'has_many', :variety => layout_row),
    Habanero::AssociationIngredient.new(:name => 'Row', :relation => 'belongs_to', :variety => region),
  ]
)
=end
# Phase 18 - Add Slug Ingredients
=begin
brand = Habanero::Variety.find_by_name('Brand')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => brand, :target => brand.ingredients.find_by_name('Name'))

variety = Habanero::Variety.find_by_name('Variety')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => variety, :target => variety.ingredients.find_by_name('Name'), :scope => variety.ingredients.find_by_name('Brand'))

ingredient = Habanero::Variety.find_by_name('Ingredient')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => ingredient, :target => ingredient.ingredients.find_by_name('Name'), :scope => ingredient.ingredients.find_by_name('Variety'))

mask = Habanero::Variety.find_by_name('Mask')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => mask, :target => mask.ingredients.find_by_name('Name'), :scope => mask.ingredients.find_by_name('Variety'))

category = Habanero::Variety.find_by_name('Category')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => category, :target => category.ingredients.find_by_name('Name'))

site = Habanero::Variety.find_by_name('Site')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => site, :target => site.ingredients.find_by_name('Name'))

section = Habanero::Variety.find_by_name('Section')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => section, :target => section.ingredients.find_by_name('Name'), :scope => section.ingredients.find_by_name('Site'))

page = Habanero::Variety.find_by_name('Page')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => page, :target => page.ingredients.find_by_name('Name'), :scope => page.ingredients.find_by_name('Section'))

scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => scoop, :target => scoop.ingredients.find_by_name('Name'))

layout = Habanero::Variety.find_by_name('Layout')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => layout, :target => layout.ingredients.find_by_name('Name'))

region = Habanero::Variety.find_by_name('Region')
Habanero::SlugIngredient.create!(:name => 'Slug', :variety => region, :target => region.ingredients.find_by_name('Name'), :scope => region.ingredients.find_by_name('Layout'))
=end
# Phase 17 - Invent Slug Ingredient
=begin
brand = Habanero::Brand.find_by_name('Habanero')
ingredient = Habanero::Variety.find_by_name('Ingredient')
assoc_ingredient = Habanero::Variety.find_by_name('AssociationIngredient')

s_ingredient = Habanero::Variety.create!(:name => 'SlugIngredient', :brand => brand, :parent => ingredient)

Habanero::RelationIngredient.create!(
  :name => 'Target Slug Ingredients',
  :variety => s_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Slug Ingredients', :relation => 'has_many', :variety => ingredient),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :variety => s_ingredient),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Scope Slug Ingredients',
  :variety => s_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Slug Ingredients', :relation => 'has_many', :variety => assoc_ingredient),
    Habanero::AssociationIngredient.new(:name => 'Scope', :relation => 'belongs_to', :variety => s_ingredient),
  ]
)
=end
# Phase 16 - Category Ingredient
=begin
brand = Habanero::Brand.find_by_name('Habanero')
ingredient = Habanero::Variety.find_by_name('Ingredient')
category = Habanero::Variety.find_by_name('Category')

c_ingredient = Habanero::Variety.create!(:name => 'CategoryIngredient', :brand => brand, :parent => ingredient)

Habanero::RelationIngredient.create!(
  :name => 'Category Ingredients',
  :variety => c_ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredients', :relation => 'has_many', :variety => category),
    Habanero::AssociationIngredient.new(:name => 'Category', :relation => 'belongs_to', :variety => c_ingredient),
  ]
)
=end
# Phase 15 - Create category variety
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

c = Habanero::Variety.create!(:name => 'Category', :brand => brand, :parent => active_record)
nest = Habanero::NestIngredient.create!(:name => 'Nest', :variety => c)
name = Habanero::StringIngredient.create!(:name => 'Name', :variety => c)
abbrev = Habanero::StringIngredient.create!(:name => 'Abbreviation', :variety => c)
strat = Habanero::TextIngredient.create!(:name => 'Strategy', :variety => c)

mask = Habanero::Mask.create!(:name => 'Category Document Mask', :variety => c)
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
# Phase 14 - Create a variety edit page
=begin
ingredient = Habanero::Variety.find_by_name('Ingredient')
ref = Habanero::Section.find_by_name('Reference Manual')
next_page = Habanero::Page.find_by_name('Ingredient Page')
page = Habanero::Page.create!(:name => 'Ingredient Edit Page', :section => ref, :route => '/ingredients/:id/edit', :target => ingredient, :next_page => next_page)

scoop = Habanero::DocumentationScoop.find_by_name('Ingredient Document')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'edit')
=end
# Phase 13 - Create a variety edit page
=begin
ref = Habanero::Section.find_by_name('Reference Manual')
next_page = Habanero::Page.find_by_name('Variety Page')
page = Habanero::Page.create!(:name => 'Variety Edit Page', :section => ref, :route => '/varieties/:id/edit', :next_page => next_page)

scoop = Habanero::DocumentationScoop.find_by_name('Variety Document')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'edit')
=end
# Phase 12 - Add a next page ingredient to pages, create a variety edit page
=begin
p_variety = Habanero::Variety.find_by_name('Page')

Habanero::RelationIngredient.create!(
  :name => 'Previous Next Pages',
  :variety => p_variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Previous Pages', :relation => 'has_many', :variety => p_variety),
    Habanero::AssociationIngredient.new(:name => 'Next Page', :relation => 'belongs_to', :variety => p_variety),
  ]
)
=end
# Phase 11 - Fix the ingredients documentation phase
=begin
ingredient = Habanero::Variety.find_by_name('Ingredient')
i_page = Habanero::Page.find_by_name('Ingredient Page')
i_page.target = ingredient
i_page.save!
=end
# Phase 10 - Add a target variety to page
=begin
page = Habanero::Variety.find_by_name('Page')
variety = Habanero::Variety.find_by_name('Variety')

Habanero::RelationIngredient.create!(
  :name => 'Target Pages',
  :variety => variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :variety => variety),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :variety => page),
  ]
)
=end
# Phase 9 - Invent collection scoops, reconstruct Scoop inheritance hierarchy
=begin
brand = Habanero::Brand.find_by_name('Habanero')

s = Habanero::Variety.find_by_name('Scoop')

variety_scoop = Habanero::Variety.create!(:name => 'VarietyScoop', :brand => brand, :parent => s)

# rename list scoop to collection scoop and make it a child of variety scoop
ls = Habanero::Variety.find_by_name('ListScoop')
ls.name = 'CollectionScoop'
ls.parent = variety_scoop
ls.save!

# move scoop mask to the level or variety scoop
Habanero::RelationIngredient.find_by_name('Mask Documentation Scoops').destroy

mask = Habanero::Variety.find_by_name('Mask')

Habanero::RelationIngredient.create!(
  :name => 'Mask Variety Scoops',
  :variety => mask,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Variety Scoops', :relation => 'has_many', :variety => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :variety => variety_scoop),
  ]
)

# make documentation scoop a child of variety scoop
ds = Habanero::Variety.find_by_name('DocumentationScoop')
ds.parent = variety_scoop
ds.save!

# create a new type of scoop -- Document Collection Scoop -- and create some instances for placement
mask = Habanero::Mask.find_by_name('Variety Document Mask')
variety = Habanero::Variety.create!(:name => 'DocumentationCollectionScoop', :brand => brand, :parent => ls)

s_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Variety List', :mask => mask)
i_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Ingredient List', :mask => mask)

# adjust the placements
s_placement = Habanero::ScoopPlacement.find(1)
s_placement.scoop = s_scoop
s_placement.save!

i_placement = Habanero::ScoopPlacement.find(3)
i_placement.scoop = i_scoop
i_placement.save!
=end
# Phase 8 - start building habanero site variety2 doco section
=begin
variety = Habanero::Variety.find_by_name('Variety')
ingredient = Habanero::Variety.find_by_name('Ingredient')

# move template column from Scoop to ScoopPlacement so we can reuse a scoop and apply a different template when placed
#Habanero::Variety.find_by_name('Scoop').ingredients.find_by_name('Template').destroy

#placement = Habanero::Variety.find_by_name('ScoopPlacement')
#Habanero::StringIngredient.create!(:name => 'Template', :variety => placement)

#Habanero::Scoop.reset_column_information
#Habanero::ScoopPlacement.reset_column_information

# build the site, section and pages
site = Habanero::Site.create!(:name => 'Habanero')
variety2 = Habanero::Section.create!(:name => 'Sorbet2', :route => '/variety2', :site => site)
ref = Habanero::Section.create!(:name => 'Reference Manual', :route => '/reference', :site => site, :target => variety, :parent => variety2)
page = Habanero::Page.create!(:name => 'Variety Page', :section => ref, :route => '/varieties/:id')
i_page = Habanero::Page.create!(:name => 'Ingredient Page', :section => ref, :route => '/ingredients/:id')

# build the scoops
mask = Habanero::Mask.create!(:name => 'Variety Document Mask', :variety => variety)
scoop = Habanero::DocumentationScoop.create!(:name => 'Variety Document', :mask => mask)
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Name'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Brand'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Variety Nest'))
mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => variety.ingredients.find_by_name('Documentation'))
mask.save!

i_mask = Habanero::Mask.create!(:name => 'Ingredient Document Mask', :variety => ingredient)
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
i_mask.mask_ingredients << Habanero::MaskIngredient.new(:ingredient => ingredient.ingredients.find_by_name('Variety'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'show')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'show')
=end
# Phase 7 - add nests to Varieties and Ingredients
=begin
variety = Habanero::Variety.find_by_name('Variety')
Habanero::NestIngredient.create!(:name => 'Variety Nest', :variety => variety)

ingredient = Habanero::Variety.find_by_name('Ingredient')
Habanero::NestIngredient.create!(:name => 'Ingredient Nest', :variety => ingredient)
=end
# Phase 6 - Documentation Ingredients, renaming MaskScoop to DocumentationScoop (which is the first specific use of Masks)
=begin
Habanero::Variety
Habanero::Ingredient
Habanero::Brand

brand = Habanero::Variety.find_by_name('Brand')
variety = Habanero::Variety.find_by_name('Variety')
ingredient = Habanero::Variety.find_by_name('Ingredient')

Habanero::TextIngredient.create!(:name => 'Documentation', :variety => brand)
Habanero::TextIngredient.create!(:name => 'Documentation', :variety => variety)
Habanero::TextIngredient.create!(:name => 'Documentation', :variety => ingredient)

s = Habanero::Variety.find_by_name('MaskScoop')
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
Habanero::Variety
Habanero::Ingredient
Habanero::Brand

brand = Habanero::Brand.find_by_name('Habanero')
ingredient = Habanero::Variety.find_by_name('Ingredient')

route = Habanero::Variety.create!(:name => 'RouteIngredient', :brand => brand, :parent => ingredient)

page = Habanero::Variety.find_by_name('Page')
page.ingredients << Habanero::RouteIngredient.new(:name => 'Route')

section = Habanero::Variety.find_by_name('Section')
section.ingredients << Habanero::RouteIngredient.new(:name => 'Route')

site = Habanero::Variety.find_by_name('Site')
site.ingredients << Habanero::StringIngredient.new(:name => 'Host')

# Phase 4 - Composite Scoops & Masks Scoop
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::NestIngredient.create!(:name => 'Nest', :variety => scoop)

section = Habanero::Variety.find_by_name('Section')
variety = Habanero::Variety.find_by_name('Variety')

Habanero::RelationIngredient.create!(
  :name => 'Target Sections',
  :variety => variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :variety => variety),
    Habanero::AssociationIngredient.new(:name => 'Target', :relation => 'belongs_to', :variety => section),
  ]
)

mask = Habanero::Variety.create!(:name => 'Mask', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => mask)
Habanero::NestIngredient.create!(:name => 'Nest', :variety => mask)

Habanero::RelationIngredient.create!(
  :name => 'Variety Masks',
  :variety => variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Masks', :relation => 'has_many', :variety => variety),
    Habanero::AssociationIngredient.new(:name => 'Variety', :relation => 'belongs_to', :variety => mask),
  ]
)

mask_ingredient = Habanero::Variety.create!(:name => 'MaskIngredient', :brand => brand, :parent => active_record)
ingredient = Habanero::Variety.find_by_name('Ingredient')

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Ingredients',
  :variety => mask,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :variety => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :variety => mask_ingredient),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Ingredient Mask Ingredients',
  :variety => ingredient,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Ingredients', :relation => 'has_many', :variety => ingredient),
    Habanero::AssociationIngredient.new(:name => 'Ingredient', :relation => 'belongs_to', :variety => mask_ingredient),
  ]
)

mask_scoop = Habanero::Variety.create!(:name => 'MaskScoop', :brand => brand, :parent => scoop)

Habanero::RelationIngredient.create!(
  :name => 'Mask Mask Scoops',
  :variety => mask,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Mask Scoops', :relation => 'has_many', :variety => mask),
    Habanero::AssociationIngredient.new(:name => 'Mask', :relation => 'belongs_to', :variety => mask_scoop),
  ]
)
=end
# Phase 3 - Basic Scoops, Placements & Regions
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

page = Habanero::Variety.find_by_name('Page')

scoop = Habanero::Variety.create!(:name => 'Scoop', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Type', :variety => scoop)
Habanero::StringIngredient.create!(:name => 'Name', :variety => scoop)
Habanero::StringIngredient.create!(:name => 'Title', :variety => scoop)
Habanero::TextIngredient.create!(:name => 'Body', :variety => scoop)
Habanero::StringIngredient.create!(:name => 'Body Format', :variety => scoop)
Habanero::StringIngredient.create!(:name => 'Template', :variety => scoop)

Habanero::Variety.create!(:name => 'ContentScoop', :brand => brand, :parent => scoop)

list_scoop = Habanero::Variety.create!(:name => 'ListScoop', :brand => brand, :parent => scoop)
Habanero::IntegerIngredient.create!(:name => 'Columns', :variety => list_scoop)

placement = Habanero::Variety.create!(:name => 'ScoopPlacement', :brand => brand, :parent => active_record)

Habanero::RelationIngredient.create!(
  :name => 'Scoop Placements',
  :variety => page,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :variety => page),
    Habanero::AssociationIngredient.new(:name => 'Page', :relation => 'belongs_to', :variety => placement),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Scoop Placements',
  :variety => scoop,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :variety => scoop),
    Habanero::AssociationIngredient.new(:name => 'Scoop', :relation => 'belongs_to', :variety => placement),
  ]
)

lay = Habanero::Variety.find_by_name('Layout')

region = Habanero::Variety.create!(:name => 'Region', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => region)

Habanero::RelationIngredient.create!(
  :name => 'Layout Regions',
  :variety => lay,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Regions', :relation => 'has_many', :variety => lay),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :variety => region),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Region Placements',
  :variety => region,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Placements', :relation => 'has_many', :variety => region),
    Habanero::AssociationIngredient.new(:name => 'Region', :relation => 'belongs_to', :variety => placement),
  ]
)
=end
# Phase 2 - Sites, Sections & Pages
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

site = Habanero::Variety.create!(:name => 'Site', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => site)

section = Habanero::Variety.create!(:name => 'Section', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => section)
Habanero::NestIngredient.create!(:name => 'Nest', :variety => section)

Habanero::RelationIngredient.create!(
  :name => 'Site Sections',
  :variety => site,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :variety => site),
    Habanero::AssociationIngredient.new(:name => 'Site', :relation => 'belongs_to', :variety => section),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Template Sections',
  :variety => section,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Sections', :relation => 'has_many', :variety => section),
    Habanero::AssociationIngredient.new(:name => 'Template', :relation => 'belongs_to', :variety => section),
  ]
)

page = Habanero::Variety.create!(:name => 'Page', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => page)

l = Habanero::Variety.create!(:name => 'Layout', :brand => brand, :parent => active_record)
Habanero::StringIngredient.create!(:name => 'Name', :variety => l)

Habanero::RelationIngredient.create!(
  :name => 'Section Pages',
  :variety => section,
  :ordered => true,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :variety => section),
    Habanero::AssociationIngredient.new(:name => 'Section', :relation => 'belongs_to', :variety => page),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Layout Pages',
  :variety => l,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :variety => l),
    Habanero::AssociationIngredient.new(:name => 'Layout', :relation => 'belongs_to', :variety => page),
  ]
)

Habanero::RelationIngredient.create!(
  :name => 'Template Pages',
  :variety => page,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Pages', :relation => 'has_many', :variety => page),
    Habanero::AssociationIngredient.new(:name => 'Template', :relation => 'belongs_to', :variety => page),
  ]
)
=end
# Phase 1 - Brand, Variety & Ingredient Definition
=begin
active_record = Habanero::Variety.create!(
  :brand => Habanero::Brand.new(:name => 'ActiveRecord'),
  :name => 'Base'
)

brand = Habanero::Brand.create!(:name => 'Habanero')

ingredient = Habanero::Variety.create!(:name => 'Ingredient', :brand => brand, :parent => active_record)

Habanero::Variety.create!(:name => 'StringIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'IntegerIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'TrueFalseIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'TextIngredient', :brand => brand, :parent => ingredient)

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

variety = Habanero::Variety.create!(:name => 'Variety', :brand => brand, :parent => active_record)
brand_variety = Habanero::Variety.create!(:name => 'Brand', :brand => brand, :parent => active_record)

Habanero::Variety.create!(:name => 'BlobIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'CurrencyIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'DateIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'DateTimeIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'DecimalIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'NumberIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'PercentageIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'TimeIngredient', :brand => brand, :parent => ingredient)

Habanero::Variety.create!(:name => 'RelationIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'AssociationIngredient', :brand => brand, :parent => ingredient)
Habanero::Variety.create!(:name => 'NestIngredient', :brand => brand, :parent => ingredient)

Habanero::StringIngredient.create!(:name => 'Name', :variety => variety)
Habanero::RelationIngredient.create!(
  :name => 'Variety Ingredients',
  :variety => variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Ingredients', :relation => 'has_many', :variety => variety),
    Habanero::AssociationIngredient.new(:name => 'Variety', :relation => 'belongs_to', :variety => ingredient),
  ]
)

Habanero::StringIngredient.create!(:name => 'Name', :variety => brand_variety)
Habanero::RelationIngredient.create!(
  :name => 'Brand Varieties',
  :variety => brand_variety,
  :children => [
    Habanero::AssociationIngredient.new(:name => 'Varieties', :relation => 'has_many', :variety => brand_variety),
    Habanero::AssociationIngredient.new(:name => 'Brand', :relation => 'belongs_to', :variety => variety),
  ]
)
=end
