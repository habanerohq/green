require 'spec_helper'

describe Habanero::SlugTrait do
  it { should belong_to(:target) }
  it { should belong_to(:scope) }

  before(:each) do
    @book = Habanero::Variety.new(
      :name => 'Book',
      :parent => Habanero::Variety.branded('ActiveRecord').where(:name => 'Base').first,
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    title = Habanero::StringTrait.new(:name => 'Title')
    slug = Habanero::SlugTrait.new(:name => 'Slug', :target => title)

    # a related variety with which we can test scoped slugs
    @author = Habanero::Variety.new(
      :name => 'Author',
      :parent => Habanero::Variety.branded('ActiveRecord').where(:name => 'Base').first,
      :brand => Habanero::Brand.find_by_name('Habanero')
    )

    name = Habanero::StringTrait.new(:name => 'Name')

    relation = Habanero::RelationTrait.new(
      :name => 'Author Books',
      :children => [
        Habanero::AssociationTrait.new(:name => 'Author', :relation => 'belongs_to', :variety => @book),
        Habanero::AssociationTrait.new(:name => 'Books', :relation => 'has_many', :variety => @author)
      ]
    )

    @book.traits = [title, slug, relation]
    @author.traits = [name]

    @book.save!
    @book.germinate!
  end

  after(:each) do
    Habanero.send :remove_const, 'Book'
    Habanero.send :remove_const, 'Author'
  end

  it 'extends friendly id' do
    @book.klass.new.should respond_to :friendly_id
  end

  it 'generates a slug using the value of the target trait' do
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
      # re-configure the existing slug trait to be scoped by author
      @book.traits.find_by_name('Slug').update_attribute(
        :scope_id,
        @book.traits.find_by_name('Author').id
      )

      @book.brand.klass.send :remove_const, 'Book'
      @book.germinate!
    end

    it 'is invalid when scope trait does not belong to the same variety' do
      slug = @book.traits.find_by_name('Slug')
      slug.scope = Habanero::Variety.find_by_name('Variety').traits.find_by_name('Brand')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not present on the target variety"
    end

    it 'is invalid when target trait is not a belongs_to association trait' do
      slug = @book.traits.find_by_name('Slug')
      slug.scope = Habanero::Variety.find_by_name('Variety').traits.find_by_name('Traits')
      slug.should_not be_valid
      slug.errors_on(:scope).should include "is not a belongs_to association"
    end

    it 'adds a non-unique index on the slug column' do
      index = ActiveRecord::Base.connection.indexes(@book.table_name).detect { |i| "index_#{@book.table_name}_on_slug" }
      index.should_not be_nil
      index.unique.should be_false
    end

    it 'scopes slugs by the target trait' do
      record1 = @book.klass.create!(:title => 'The Time Machine', :author => @author.klass.new(:name => 'Wells'))
      record2 = @book.klass.create!(:title => 'The Time Machine', :author => @author.klass.new(:name => 'Someone Else'))
      record2.slug.should == record1.slug
    end
  end
end
