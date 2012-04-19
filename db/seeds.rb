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

# Phase 37 - fix variety tree sieve hierarchy
=begin
scoop = Habanero::Page.find_by_name('Variety Kitchen').placements.first.scoop
scoop.sieve = Habanero::Sieve.find_by_name('Brand Tree Sieve')
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
# Phase 35 - Make our Varieties use NameTrait
=begin
Habanero::Trait.update_all("type = 'Habanero::NameTrait'", "type = 'Habanero::StringTrait' AND name = 'Name'")
=end
# Phase 34 - Fix NameTrait
=begin
trait = Habanero::Variety.find_by_name('Trait')
brand = Habanero::Brand.find_by_name('Habanero')

name_trait = Habanero::Variety.create!(
  :name => 'NameTrait',
  :parent => trait,
  :brand => brand
)

Habanero::StringTrait.create!(:name => 'Format', :variety => name_trait)
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

Habanero::RelationTrait.create!(
  :name => 'Page VarietyScoops',
  :variety => scoop,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Page', :relation => 'belongs_to', :variety => scoop),
    Habanero::AssociationTrait.new(:name => 'VarietyScoops', :relation => 'has_many', :variety => page)
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
# build the sieves
site = Habanero::Variety.find_by_name('Site')
site_sieve = Habanero::Sieve.create!(:name => 'Site Tree Sieve', :variety => site)
site_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => site.traits.find_by_name('Sections'))
site_sieve.save!

section = Habanero::Variety.find_by_name('Section')
section_sieve = Habanero::Sieve.create!(:name => 'Section Tree Sieve', :variety => section, :parent => site_sieve)
section_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => section.traits.find_by_name('Pages'))
section_sieve.save!

page = Habanero::Variety.find_by_name('Page')
page_sieve = Habanero::Sieve.create!(:name => 'Page Tree Sieve', :variety => page, :parent => section_sieve)
page_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => page.traits.find_by_name('Placements'))
page_sieve.save!

scoop = Habanero::Variety.find_by_name('Scoop')
scoop_sieve = Habanero::Sieve.create!(:name => 'Scoop Tree Sieve', :variety => scoop)
scoop_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => scoop.traits.find_by_name('Placements'))
scoop_sieve.save!

brand = Habanero::Variety.find_by_name('Brand')
brand_sieve = Habanero::Sieve.create!(:name => 'Brand Tree Sieve', :variety => brand)
brand_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => brand.traits.find_by_name('Varieties'))
brand_sieve.save!

variety = Habanero::Variety.find_by_name('Variety')
variety_sieve = Habanero::Sieve.create!(:name => 'Variety Tree Sieve', :variety => variety, :parent => brand_sieve)
variety_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Traits'))
variety_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Sieves'))
variety_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Graders'))
variety_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Sections'))
variety_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Pages'))
variety_sieve.save!

sieve = Habanero::Variety.find_by_name('Sieve')
sieve_sieve = Habanero::Sieve.create!(:name => 'Sieve Tree Sieve', :variety => sieve, :parent => variety_sieve)
sieve_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => sieve.traits.find_by_name('Sieve Traits'))
sieve_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => sieve.traits.find_by_name('Variety Scoops'))
sieve_sieve.save!

category = Habanero::Variety.find_by_name('Category')
category_sieve = Habanero::Sieve.create!(:name => 'Category Tree Sieve', :variety => category)
category_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => category.traits.find_by_name('Traits'))
category_sieve.save!

page = Habanero::Page.find_by_name('Layout Kitchen')

# build the scoops
site_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Site Tree', :sieve => Habanero::Sieve.find_by_name('Site Tree Sieve'))
scoop_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Scoop Tree', :sieve => Habanero::Sieve.find_by_name('Scoop Tree Sieve'))
variety_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Variety Tree', :sieve => Habanero::Sieve.find_by_name('Variety Tree Sieve'))
category_scoop = Habanero::VarietyCollectionScoop.create!(:name => 'Category Tree', :sieve => Habanero::Sieve.find_by_name('Category Tree Sieve'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => site_scoop, :region => page.layout.regions.find_by_name('Left'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => variety_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
Habanero::ScoopPlacement.create!(:page => page, :scoop => category_scoop, :region => page.layout.regions.find_by_name('Right'), :template => 'tree')
=end
# Phase 29 - Create some Layout Sieves for tree rendering
=begin
layout = Habanero::Variety.find_by_name('Layout')
l_sieve = Habanero::Sieve.create!(:name => 'Layout Tree Sieve', :variety => layout)
l_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => layout.traits.find_by_name('Rows'))
l_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => layout.traits.find_by_name('Pages'))
l_sieve.save!

row = Habanero::Variety.find_by_name('LayoutRow')
row_sieve = Habanero::Sieve.create!(:name => 'Layout Row Tree Sieve', :variety => row, :parent => l_sieve)
row_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => row.traits.find_by_name('Regions'))
row_sieve.save!

region = Habanero::Variety.find_by_name('Region')
r_sieve = Habanero::Sieve.create!(:name => 'Region Tree Sieve', :variety => region, :parent => row_sieve)
r_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Placements'))
r_sieve.save!
=end
# Phase 28 - Grader on scoops
=begin
scoop = Habanero::Variety.find_by_name('Scoop')
grader = Habanero::Variety.find_by_name('Grader')

Habanero::RelationTrait.create!(
  :name => 'Grader Scoops',
  :variety => grader,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Grader', :relation => 'belongs_to', :variety => scoop),
    Habanero::AssociationTrait.new(:name => 'Scoops', :relation => 'has_many', :variety => grader)
  ]
)

# Phase 27 - Grader
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

grader = Habanero::Variety.create!(:name => 'Grader', :parent => active_record, :brand => brand)
grader.traits << Habanero::StringTrait.new(:name => 'Name')

Habanero::RelationTrait.create!(
  :name => 'Variety Graders',
  :variety => grader,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Variety', :relation => 'belongs_to', :variety => grader),
    Habanero::AssociationTrait.new(:name => 'Graders', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Variety'))
  ]
)

condition = Habanero::Variety.create!(:name => 'Condition', :parent => active_record, :brand => brand)
condition.traits << Habanero::StringTrait.new(:name => 'Predicate') # todo: should not be a StringTrait
condition.traits << Habanero::StringTrait.new(:name => 'Value')

Habanero::RelationTrait.create!(
  :name => 'Trait Conditions',
  :variety => condition,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Trait', :relation => 'belongs_to', :variety => condition),
    Habanero::AssociationTrait.new(:name => 'Conditions', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Trait'))
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Grader Conditions',
  :variety => grader,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Grader', :relation => 'belongs_to', :variety => condition),
    Habanero::AssociationTrait.new(:name => 'Conditions', :relation => 'has_many', :variety => grader)
  ]
)
=end
# Phase 26 - add template back into Scoop
=begin
scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::StringTrait.create!(:name => 'Template', :variety => scoop)
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
# Phase 24 - Create some Layout Sieves
=begin
layout = Habanero::Variety.find_by_name('Layout')
sieve = Habanero::Sieve.create!(:name => 'Layout Sieve', :variety => layout)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => layout.traits.find_by_name('Name'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => layout.traits.find_by_name('Template Name'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => layout.traits.find_by_name('Fluid'))
sieve.save!

row = Habanero::Variety.find_by_name('LayoutRow')
sieve = Habanero::Sieve.create!(:name => 'Layout Row Sieve', :variety => row)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => row.traits.find_by_name('Layout'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => row.traits.find_by_name('Name'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => row.traits.find_by_name('Fluid'))
sieve.save!

region = Habanero::Variety.find_by_name('Region')
sieve = Habanero::Sieve.create!(:name => 'Region Sieve', :variety => region)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Layout'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Row'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Name'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Span'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => region.traits.find_by_name('Offset'))
sieve.save!
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
Habanero::StringTrait.create!(:name => 'Template Name', :variety => layout)
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
Habanero::TrueFalseTrait.create!(:name => 'Fluid', :variety => layout)

region = Habanero::Variety.find_by_name('Region')
Habanero::IntegerTrait.create!(:name => 'Span', :variety => region)
Habanero::IntegerTrait.create!(:name => 'Offset', :variety => region)

layout_row = Habanero::Variety.create!(:name => 'LayoutRow', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => layout_row)
Habanero::TrueFalseTrait.create!(:name => 'Fluid', :variety => layout_row)

Habanero::RelationTrait.create!(
  :name => 'Layout Rows',
  :variety => layout,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Rows', :relation => 'has_many', :variety => layout),
    Habanero::AssociationTrait.new(:name => 'Layout', :relation => 'belongs_to', :variety => layout_row),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Row Regions',
  :variety => layout_row,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Regions', :relation => 'has_many', :variety => layout_row),
    Habanero::AssociationTrait.new(:name => 'Row', :relation => 'belongs_to', :variety => region),
  ]
)
=end
# Phase 18 - Add Slug Traits
=begin
brand = Habanero::Variety.find_by_name('Brand')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => brand, :target => brand.traits.find_by_name('Name'))

variety = Habanero::Variety.find_by_name('Variety')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => variety, :target => variety.traits.find_by_name('Name'), :scope => variety.traits.find_by_name('Brand'))

trait = Habanero::Variety.find_by_name('Trait')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => trait, :target => trait.traits.find_by_name('Name'), :scope => trait.traits.find_by_name('Variety'))

sieve = Habanero::Variety.find_by_name('Sieve')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => sieve, :target => sieve.traits.find_by_name('Name'), :scope => sieve.traits.find_by_name('Variety'))

category = Habanero::Variety.find_by_name('Category')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => category, :target => category.traits.find_by_name('Name'))

site = Habanero::Variety.find_by_name('Site')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => site, :target => site.traits.find_by_name('Name'))

section = Habanero::Variety.find_by_name('Section')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => section, :target => section.traits.find_by_name('Name'), :scope => section.traits.find_by_name('Site'))

page = Habanero::Variety.find_by_name('Page')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => page, :target => page.traits.find_by_name('Name'), :scope => page.traits.find_by_name('Section'))

scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => scoop, :target => scoop.traits.find_by_name('Name'))

layout = Habanero::Variety.find_by_name('Layout')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => layout, :target => layout.traits.find_by_name('Name'))

region = Habanero::Variety.find_by_name('Region')
Habanero::SlugTrait.create!(:name => 'Slug', :variety => region, :target => region.traits.find_by_name('Name'), :scope => region.traits.find_by_name('Layout'))
=end
# Phase 17 - Invent Slug Trait
=begin
brand = Habanero::Brand.find_by_name('Habanero')
trait = Habanero::Variety.find_by_name('Trait')
assoc_trait = Habanero::Variety.find_by_name('AssociationTrait')

s_trait = Habanero::Variety.create!(:name => 'SlugTrait', :brand => brand, :parent => trait)

Habanero::RelationTrait.create!(
  :name => 'Target Slug Traits',
  :variety => s_trait,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Slug Traits', :relation => 'has_many', :variety => trait),
    Habanero::AssociationTrait.new(:name => 'Target', :relation => 'belongs_to', :variety => s_trait),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Scope Slug Traits',
  :variety => s_trait,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Slug Traits', :relation => 'has_many', :variety => assoc_trait),
    Habanero::AssociationTrait.new(:name => 'Scope', :relation => 'belongs_to', :variety => s_trait),
  ]
)
=end
# Phase 16 - Category Trait
=begin
brand = Habanero::Brand.find_by_name('Habanero')
trait = Habanero::Variety.find_by_name('Trait')
category = Habanero::Variety.find_by_name('Category')

c_trait = Habanero::Variety.create!(:name => 'CategoryTrait', :brand => brand, :parent => trait)

Habanero::RelationTrait.create!(
  :name => 'Category Traits',
  :variety => c_trait,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Traits', :relation => 'has_many', :variety => category),
    Habanero::AssociationTrait.new(:name => 'Category', :relation => 'belongs_to', :variety => c_trait),
  ]
)
=end
# Phase 15 - Create category variety
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

c = Habanero::Variety.create!(:name => 'Category', :brand => brand, :parent => active_record)
nest = Habanero::NestTrait.create!(:name => 'Nest', :variety => c)
name = Habanero::StringTrait.create!(:name => 'Name', :variety => c)
abbrev = Habanero::StringTrait.create!(:name => 'Abbreviation', :variety => c)
strat = Habanero::TextTrait.create!(:name => 'Strategy', :variety => c)

sieve = Habanero::Sieve.create!(:name => 'Category Document Sieve', :variety => c)
scoop = Habanero::DocumentationScoop.create!(:name => 'Category Document', :sieve => sieve)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => name)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => nest)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => abbrev)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => strat)

ref = Habanero::Section.find_by_name('Reference Manual')
content_page = Habanero::Page.create!(:name => 'Category Page', :section => ref, :route => '/traits/:id', :target => c)
edit_page = Habanero::Page.create!(:name => 'Category Edit Page', :section => ref, :route => '/traits/:id/edit', :target => c, :next_page => content_page)

Habanero::ScoopPlacement.create!(:page => edit_page, :scoop => scoop, :template => 'edit')
Habanero::ScoopPlacement.create!(:page => content_page, :scoop => scoop, :template => 'show')
=end
# Phase 14 - Create a variety edit page
=begin
trait = Habanero::Variety.find_by_name('Trait')
ref = Habanero::Section.find_by_name('Reference Manual')
next_page = Habanero::Page.find_by_name('Trait Page')
page = Habanero::Page.create!(:name => 'Trait Edit Page', :section => ref, :route => '/traits/:id/edit', :target => trait, :next_page => next_page)

scoop = Habanero::DocumentationScoop.find_by_name('Trait Document')
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
# Phase 12 - Add a next page trait to pages, create a variety edit page
=begin
p_variety = Habanero::Variety.find_by_name('Page')

Habanero::RelationTrait.create!(
  :name => 'Previous Next Pages',
  :variety => p_variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Previous Pages', :relation => 'has_many', :variety => p_variety),
    Habanero::AssociationTrait.new(:name => 'Next Page', :relation => 'belongs_to', :variety => p_variety),
  ]
)
=end
# Phase 11 - Fix the traits documentation phase
=begin
trait = Habanero::Variety.find_by_name('Trait')
i_page = Habanero::Page.find_by_name('Trait Page')
i_page.target = trait
i_page.save!
=end
# Phase 10 - Add a target variety to page
=begin
page = Habanero::Variety.find_by_name('Page')
variety = Habanero::Variety.find_by_name('Variety')

Habanero::RelationTrait.create!(
  :name => 'Target Pages',
  :variety => variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Pages', :relation => 'has_many', :variety => variety),
    Habanero::AssociationTrait.new(:name => 'Target', :relation => 'belongs_to', :variety => page),
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

# move scoop sieve to the level or variety scoop
Habanero::RelationTrait.find_by_name('Sieve Documentation Scoops').destroy

sieve = Habanero::Variety.find_by_name('Sieve')

Habanero::RelationTrait.create!(
  :name => 'Sieve Variety Scoops',
  :variety => sieve,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Variety Scoops', :relation => 'has_many', :variety => sieve),
    Habanero::AssociationTrait.new(:name => 'Sieve', :relation => 'belongs_to', :variety => variety_scoop),
  ]
)

# make documentation scoop a child of variety scoop
ds = Habanero::Variety.find_by_name('DocumentationScoop')
ds.parent = variety_scoop
ds.save!

# create a new type of scoop -- Document Collection Scoop -- and create some instances for placement
sieve = Habanero::Sieve.find_by_name('Variety Document Sieve')
variety = Habanero::Variety.create!(:name => 'DocumentationCollectionScoop', :brand => brand, :parent => ls)

s_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Variety List', :sieve => sieve)
i_scoop = Habanero::DocumentationCollectionScoop.create!(:name => 'Trait List', :sieve => sieve)

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
trait = Habanero::Variety.find_by_name('Trait')

# move template column from Scoop to ScoopPlacement so we can reuse a scoop and apply a different template when placed
#Habanero::Variety.find_by_name('Scoop').traits.find_by_name('Template').destroy

#placement = Habanero::Variety.find_by_name('ScoopPlacement')
#Habanero::StringTrait.create!(:name => 'Template', :variety => placement)

#Habanero::Scoop.reset_column_information
#Habanero::ScoopPlacement.reset_column_information

# build the site, section and pages
site = Habanero::Site.create!(:name => 'Habanero')
variety2 = Habanero::Section.create!(:name => 'Sorbet2', :route => '/variety2', :site => site)
ref = Habanero::Section.create!(:name => 'Reference Manual', :route => '/reference', :site => site, :target => variety, :parent => variety2)
page = Habanero::Page.create!(:name => 'Variety Page', :section => ref, :route => '/varieties/:id')
i_page = Habanero::Page.create!(:name => 'Trait Page', :section => ref, :route => '/traits/:id')

# build the scoops
sieve = Habanero::Sieve.create!(:name => 'Variety Document Sieve', :variety => variety)
scoop = Habanero::DocumentationScoop.create!(:name => 'Variety Document', :sieve => sieve)
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Name'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Brand'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Variety Nest'))
sieve.sieve_traits << Habanero::SieveTrait.new(:trait => variety.traits.find_by_name('Documentation'))
sieve.save!

i_sieve = Habanero::Sieve.create!(:name => 'Trait Document Sieve', :variety => trait)
i_scoop = Habanero::DocumentationScoop.create!(:name => 'Trait Document', :sieve => i_sieve)
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Name'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Type'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Documentation'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Derived'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Limit'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Precision'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Scale'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Default'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Nullable'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Sortable'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Sort Direction'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Ordered'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Relation'))
i_sieve.sieve_traits << Habanero::SieveTrait.new(:trait => trait.traits.find_by_name('Variety'))

# build the placements
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => page, :scoop => scoop, :template => 'show')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'list')
Habanero::ScoopPlacement.create!(:page => i_page, :scoop => i_scoop, :template => 'show')
=end
# Phase 7 - add nests to Varieties and Traits
=begin
variety = Habanero::Variety.find_by_name('Variety')
Habanero::NestTrait.create!(:name => 'Variety Nest', :variety => variety)

trait = Habanero::Variety.find_by_name('Trait')
Habanero::NestTrait.create!(:name => 'Trait Nest', :variety => trait)
=end
# Phase 6 - Documentation Traits, renaming SieveScoop to DocumentationScoop (which is the first specific use of Sieves)
=begin
Habanero::Variety
Habanero::Trait
Habanero::Brand

brand = Habanero::Variety.find_by_name('Brand')
variety = Habanero::Variety.find_by_name('Variety')
trait = Habanero::Variety.find_by_name('Trait')

Habanero::TextTrait.create!(:name => 'Documentation', :variety => brand)
Habanero::TextTrait.create!(:name => 'Documentation', :variety => variety)
Habanero::TextTrait.create!(:name => 'Documentation', :variety => trait)

s = Habanero::Variety.find_by_name('SieveScoop')
s.name = 'DocumentationScoop'
s.save!

r = Habanero::RelationTrait.find_by_name('Sieve Sieve Scoops')
r.name = 'Sieve Documentation Scoops'
r.save!

a = Habanero::AssociationTrait.find_by_name('Sieve Scoops')
a.name = 'Documentation Scoop'
a.save!
=end
# Phase 5 - Routes
=begin
Habanero::Variety
Habanero::Trait
Habanero::Brand

brand = Habanero::Brand.find_by_name('Habanero')
trait = Habanero::Variety.find_by_name('Trait')

route = Habanero::Variety.create!(:name => 'RouteTrait', :brand => brand, :parent => trait)

page = Habanero::Variety.find_by_name('Page')
page.traits << Habanero::RouteTrait.new(:name => 'Route')

section = Habanero::Variety.find_by_name('Section')
section.traits << Habanero::RouteTrait.new(:name => 'Route')

site = Habanero::Variety.find_by_name('Site')
site.traits << Habanero::StringTrait.new(:name => 'Host')

# Phase 4 - Composite Scoops & Sieves Scoop
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

scoop = Habanero::Variety.find_by_name('Scoop')
Habanero::NestTrait.create!(:name => 'Nest', :variety => scoop)

section = Habanero::Variety.find_by_name('Section')
variety = Habanero::Variety.find_by_name('Variety')

Habanero::RelationTrait.create!(
  :name => 'Target Sections',
  :variety => variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sections', :relation => 'has_many', :variety => variety),
    Habanero::AssociationTrait.new(:name => 'Target', :relation => 'belongs_to', :variety => section),
  ]
)

sieve = Habanero::Variety.create!(:name => 'Sieve', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => sieve)
Habanero::NestTrait.create!(:name => 'Nest', :variety => sieve)

Habanero::RelationTrait.create!(
  :name => 'Variety Sieves',
  :variety => variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sieves', :relation => 'has_many', :variety => variety),
    Habanero::AssociationTrait.new(:name => 'Variety', :relation => 'belongs_to', :variety => sieve),
  ]
)

sieve_trait = Habanero::Variety.create!(:name => 'SieveTrait', :brand => brand, :parent => active_record)
trait = Habanero::Variety.find_by_name('Trait')

Habanero::RelationTrait.create!(
  :name => 'Sieve Sieve Traits',
  :variety => sieve,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sieve Traits', :relation => 'has_many', :variety => sieve),
    Habanero::AssociationTrait.new(:name => 'Sieve', :relation => 'belongs_to', :variety => sieve_trait),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Trait Sieve Traits',
  :variety => trait,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sieve Traits', :relation => 'has_many', :variety => trait),
    Habanero::AssociationTrait.new(:name => 'Trait', :relation => 'belongs_to', :variety => sieve_trait),
  ]
)

sieve_scoop = Habanero::Variety.create!(:name => 'SieveScoop', :brand => brand, :parent => scoop)

Habanero::RelationTrait.create!(
  :name => 'Sieve Sieve Scoops',
  :variety => sieve,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sieve Scoops', :relation => 'has_many', :variety => sieve),
    Habanero::AssociationTrait.new(:name => 'Sieve', :relation => 'belongs_to', :variety => sieve_scoop),
  ]
)
=end
# Phase 3 - Basic Scoops, Placements & Regions
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

page = Habanero::Variety.find_by_name('Page')

scoop = Habanero::Variety.create!(:name => 'Scoop', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Type', :variety => scoop)
Habanero::StringTrait.create!(:name => 'Name', :variety => scoop)
Habanero::StringTrait.create!(:name => 'Title', :variety => scoop)
Habanero::TextTrait.create!(:name => 'Body', :variety => scoop)
Habanero::StringTrait.create!(:name => 'Body Format', :variety => scoop)
Habanero::StringTrait.create!(:name => 'Template', :variety => scoop)

Habanero::Variety.create!(:name => 'ContentScoop', :brand => brand, :parent => scoop)

list_scoop = Habanero::Variety.create!(:name => 'ListScoop', :brand => brand, :parent => scoop)
Habanero::IntegerTrait.create!(:name => 'Columns', :variety => list_scoop)

placement = Habanero::Variety.create!(:name => 'ScoopPlacement', :brand => brand, :parent => active_record)

Habanero::RelationTrait.create!(
  :name => 'Scoop Placements',
  :variety => page,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Placements', :relation => 'has_many', :variety => page),
    Habanero::AssociationTrait.new(:name => 'Page', :relation => 'belongs_to', :variety => placement),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Scoop Placements',
  :variety => scoop,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Placements', :relation => 'has_many', :variety => scoop),
    Habanero::AssociationTrait.new(:name => 'Scoop', :relation => 'belongs_to', :variety => placement),
  ]
)

lay = Habanero::Variety.find_by_name('Layout')

region = Habanero::Variety.create!(:name => 'Region', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => region)

Habanero::RelationTrait.create!(
  :name => 'Layout Regions',
  :variety => lay,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Regions', :relation => 'has_many', :variety => lay),
    Habanero::AssociationTrait.new(:name => 'Layout', :relation => 'belongs_to', :variety => region),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Region Placements',
  :variety => region,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Placements', :relation => 'has_many', :variety => region),
    Habanero::AssociationTrait.new(:name => 'Region', :relation => 'belongs_to', :variety => placement),
  ]
)
=end
# Phase 2 - Sites, Sections & Pages
=begin
brand = Habanero::Brand.find_by_name('Habanero')
active_record = Habanero::Variety.find_by_name('Base')

site = Habanero::Variety.create!(:name => 'Site', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => site)

section = Habanero::Variety.create!(:name => 'Section', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => section)
Habanero::NestTrait.create!(:name => 'Nest', :variety => section)

Habanero::RelationTrait.create!(
  :name => 'Site Sections',
  :variety => site,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sections', :relation => 'has_many', :variety => site),
    Habanero::AssociationTrait.new(:name => 'Site', :relation => 'belongs_to', :variety => section),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Template Sections',
  :variety => section,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Sections', :relation => 'has_many', :variety => section),
    Habanero::AssociationTrait.new(:name => 'Template', :relation => 'belongs_to', :variety => section),
  ]
)

page = Habanero::Variety.create!(:name => 'Page', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => page)

l = Habanero::Variety.create!(:name => 'Layout', :brand => brand, :parent => active_record)
Habanero::StringTrait.create!(:name => 'Name', :variety => l)

Habanero::RelationTrait.create!(
  :name => 'Section Pages',
  :variety => section,
  :ordered => true,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Pages', :relation => 'has_many', :variety => section),
    Habanero::AssociationTrait.new(:name => 'Section', :relation => 'belongs_to', :variety => page),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Layout Pages',
  :variety => l,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Pages', :relation => 'has_many', :variety => l),
    Habanero::AssociationTrait.new(:name => 'Layout', :relation => 'belongs_to', :variety => page),
  ]
)

Habanero::RelationTrait.create!(
  :name => 'Template Pages',
  :variety => page,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Pages', :relation => 'has_many', :variety => page),
    Habanero::AssociationTrait.new(:name => 'Template', :relation => 'belongs_to', :variety => page),
  ]
)
=end
# Phase 1 - Brand, Variety & Trait Definition
=begin
active_record = Habanero::Variety.create!(
  :brand => Habanero::Brand.new(:name => 'ActiveRecord'),
  :name => 'Base'
)

brand = Habanero::Brand.create!(:name => 'Habanero')

trait = Habanero::Variety.create!(:name => 'Trait', :brand => brand, :parent => active_record)

Habanero::Variety.create!(:name => 'StringTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'IntegerTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'TrueFalseTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'TextTrait', :brand => brand, :parent => trait)

trait.traits << Habanero::StringTrait.new(:name => 'Name')
trait.traits << Habanero::StringTrait.new(:name => 'Type')
trait.traits << Habanero::TrueFalseTrait.new(:name => 'Derived')
trait.traits << Habanero::IntegerTrait.new(:name => 'Limit')
trait.traits << Habanero::IntegerTrait.new(:name => 'Precision')
trait.traits << Habanero::IntegerTrait.new(:name => 'Scale')
trait.traits << Habanero::IntegerTrait.new(:name => 'Default')
trait.traits << Habanero::TrueFalseTrait.new(:name => 'Nullable')
trait.traits << Habanero::TrueFalseTrait.new(:name => 'Sortable')
trait.traits << Habanero::StringTrait.new(:name => 'Sort Direction')
trait.traits << Habanero::TrueFalseTrait.new(:name => 'Ordered')
trait.traits << Habanero::StringTrait.new(:name => 'Relation')
trait.save!

variety = Habanero::Variety.create!(:name => 'Variety', :brand => brand, :parent => active_record)
brand_variety = Habanero::Variety.create!(:name => 'Brand', :brand => brand, :parent => active_record)

Habanero::Variety.create!(:name => 'BlobTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'CurrencyTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'DateTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'DateTimeTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'DecimalTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'NumberTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'PercentageTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'TimeTrait', :brand => brand, :parent => trait)

Habanero::Variety.create!(:name => 'RelationTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'AssociationTrait', :brand => brand, :parent => trait)
Habanero::Variety.create!(:name => 'NestTrait', :brand => brand, :parent => trait)

Habanero::StringTrait.create!(:name => 'Name', :variety => variety)
Habanero::RelationTrait.create!(
  :name => 'Variety Traits',
  :variety => variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Traits', :relation => 'has_many', :variety => variety),
    Habanero::AssociationTrait.new(:name => 'Variety', :relation => 'belongs_to', :variety => trait),
  ]
)

Habanero::StringTrait.create!(:name => 'Name', :variety => brand_variety)
Habanero::RelationTrait.create!(
  :name => 'Brand Varieties',
  :variety => brand_variety,
  :children => [
    Habanero::AssociationTrait.new(:name => 'Varieties', :relation => 'has_many', :variety => brand_variety),
    Habanero::AssociationTrait.new(:name => 'Brand', :relation => 'belongs_to', :variety => variety),
  ]
)
=end
