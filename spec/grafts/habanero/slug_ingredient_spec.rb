require 'spec_helper'

describe Habanero::SlugIngredient do
  it { should belong_to(:target) }
  it { should belong_to(:scope) }

  before(:each) do
    @book = Habanero::Variety.new(
      :name => 'Book',
      :parent => Habanero::Variety.branded('ActiveRecord').where(:name => 'Base').first,
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    title = Habanero::StringIngredient.new(:name => 'Title')
    slug = Habanero::SlugIngredient.new(:name => 'Slug', :target => title)

    # a related variety with which we can test scoped slugs
    @author = Habanero::Variety.new(
      :name => 'Author',
      :parent => Habanero::Variety.branded('ActiveRecord').where(:name => 'Base').first,
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    name = Habanero::StringIngredient.new(:name => 'Name')

    relation = Habanero::RelationIngredient.new(
      :name => 'Author Books',
      :children => [
        Habanero::AssociationIngredient.new(:name => 'Author', :relation => 'belongs_to', :variety => @book),
        Habanero::AssociationIngredient.new(:name => 'Books', :relation => 'has_many', :variety => @author)
      ]
    )

    @book.ingredients = [title, slug, relation]
    @author.ingredients = [name]

    @book.save!
    @book.chill!
  end

  after(:each) do
    Habanero.send :remove_const, 'Book'
    Habanero.send :remove_const, 'Author'
  end

  it 'extends friendly id' do
    @book.klass.new.should respond_to :friendly_id
  end

  it 'generates a slug using the value of the target ingredient' do
    record = @book.klass.create!(:title => 'War and Peace')
    record.slug.should == 'war-and-peace'
  end

  it 'is findable using the slug value' do
    record = @book.klass.create!(:title => 'War of the Worlds')
    @book.klass.find(record.slug).should == record
  end

  it 'generates unscoped slugs when no scope is specified' do
    record1 = @book.klass.create!(:title => 'Dune')
    record2 = @book.klass.create!(:title => 'Dune')
    record2.slug.should_not == record1.slug
  end

  it 'adds an unique index on the slug column' do
    index = ActiveRecord::Base.connection.indexes(@book.table_name).detect { |i| "index_#{@book.table_name}_on_slug" }
    index.should_not be_nil
    index.unique.should be_true
  end

  context 'scoped' do
    before(:each) do
      # re-configure the existing slug ingredient to be scoped by author
      @book.ingredients.find_by_name('Slug').update_attribute(
        :scope_id,
        @book.ingredients.find_by_name('Author').id
      )

      @book.brand.klass.send :remove_const, 'Book'
      @book.chill!
    end

    it 'is invalid when scope ingredient does not belong to the same variety' do
      slug = @book.ingredients.find_by_name('Slug')
      slug.scope = Habanero::Variety.find_by_name('Variety').ingredients.find_by_name('Brand')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not present on the target variety"
    end

    it 'is invalid when target ingredient is not a belongs_to association ingredient' do
      slug = @book.ingredients.find_by_name('Slug')
      slug.scope = Habanero::Variety.find_by_name('Variety').ingredients.find_by_name('Ingredients')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not a belongs_to association"
    end

    it 'adds a non-unique index on the slug column' do
      index = ActiveRecord::Base.connection.indexes(@book.table_name).detect { |i| "index_#{@book.table_name}_on_slug" }
      index.should_not be_nil
      index.unique.should be_false
    end

    it 'scopes slugs by the target ingredient' do
      record1 = @book.klass.create!(:title => 'The Time Machine', :author => @author.klass.new(:name => 'Wells'))
      record2 = @book.klass.create!(:title => 'The Time Machine', :author => @author.klass.new(:name => 'Someone Else'))
      record2.slug.should == record1.slug
    end
  end
end
