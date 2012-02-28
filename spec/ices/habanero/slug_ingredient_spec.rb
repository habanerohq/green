require 'spec_helper'

describe Habanero::SlugIngredient do
  it { should belong_to(:target) }
  it { should belong_to(:scope) }

  before(:all) do
    @sorbet = Habanero::Sorbet.create!(
      :name => 'Dummy',
      :parent => Habanero::Sorbet.find_by_name('Base'),
      :namespace => Habanero::Namespace.find_by_name('Habanero')
    )

    @sorbet.ingredients << Habanero::StringIngredient.new(:name => 'Name')
    @sorbet.ingredients << Habanero::SlugIngredient.new(:name => 'Slug', :target => @sorbet.ingredients.find_by_name('Name'))

    # we need a relation in order to test scoped slugs
    Habanero::RelationIngredient.create!(
      :name => 'Site Dummies',
      :sorbet => @sorbet,
      :children => [
        Habanero::AssociationIngredient.new(:name => 'Dummies', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Site')),
        Habanero::AssociationIngredient.new(:name => 'Site', :relation => 'belongs_to', :sorbet => @sorbet)
      ]
    )

    @sorbet.chill!
  end

  after(:all) do
    Habanero::Sorbet.find_by_name('Dummy').try(:destroy)
  end

  it 'extends friendly id' do
    @sorbet.klass.new.should respond_to :friendly_id
  end

  it 'generates a slug using the value of the target ingredient' do
    record = @sorbet.klass.create!(:name => 'Bar')
    record.slug.should == 'bar'
  end

  it 'is findable using the slug value' do
    record = @sorbet.klass.create!(:name => 'Baz')
    @sorbet.klass.find(record.slug).should == record
  end

  it 'generates unscoped slugs when no scope is specified' do
    record1 = @sorbet.klass.create!(:name => 'Moo')
    record2 = @sorbet.klass.create!(:name => 'Moo')
    record2.slug.should_not == record1.slug
  end

  it 'adds an unique index on the slug column' do
    index = ActiveRecord::Base.connection.indexes(@sorbet.table_name).detect { |i| "index_#{@sorbet.table_name}_on_slug" }
    index.should_not be_nil
    index.unique.should be_true
  end

  context 'scoped' do
    before(:all) do
      @sorbet.ingredients.find_by_name('Slug').update_attribute(:scope_id, @sorbet.ingredients.find_by_name('Site').id)

      # we have to re-chill in order for the changes above to take effect
      @sorbet.namespace.klass.send :remove_const, @sorbet.klass_name
      @sorbet.chill!
    end

    it 'is invalid when scope ingredient does not belong to the same sorbet' do
      slug = @sorbet.ingredients.find_by_name('Slug')
      slug.scope = Habanero::Sorbet.find_by_name('Sorbet').ingredients.find_by_name('Namespace')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not present on the target sorbet"
    end

    it 'is invalid when target ingredient is not a belongs_to association ingredient' do
      slug = @sorbet.ingredients.find_by_name('Slug')
      slug.scope = Habanero::Sorbet.find_by_name('Sorbet').ingredients.find_by_name('Ingredients')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not a belongs_to association"
    end

    it 'adds a non-unique index on the slug column' do
      index = ActiveRecord::Base.connection.indexes(@sorbet.table_name).detect { |i| "index_#{@sorbet.table_name}_on_slug" }
      index.should_not be_nil
      index.unique.should be_false
    end

    it 'scopes slugs by the target ingredient' do
      record1 = @sorbet.klass.create!(:name => 'Zomg', :site => Habanero::Site.new)
      record2 = @sorbet.klass.create!(:name => 'Zomg', :site => Habanero::Site.new)
      record2.slug.should == record1.slug
    end
  end
end
