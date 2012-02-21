require 'spec_helper'

describe Habanero::SlugIngredient do
  it { should belong_to(:target) }
  it { should belong_to(:scope) }

  before(:each) do
    @sorbet = Habanero::Sorbet.create!(
      :name => 'Dummy',
      :parent => Habanero::Sorbet.first, # ActiveRecord::Base
      :namespace => Habanero::Namespace.find_by_name('Habanero'),
      :ingredients => [
        Habanero::StringIngredient.new(:name => 'Foo')
      ]
    )

    Habanero::RelationIngredient.create!(
      :name => 'Site Dummies',
      :sorbet => @sorbet,
      :children => [
        Habanero::AssociationIngredient.new(:name => 'Dummies', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Site')),
        Habanero::AssociationIngredient.new(:name => 'Site', :relation => 'belongs_to', :sorbet => @sorbet),
      ]
    )
  end

  after(:each) do
    @sorbet.destroy
    ActiveSupport::Dependencies.clear
  end

  pending 'should have the same sorbet for the target and scope ingredients'

  it 'do stuff' do
    @sorbet.ingredients << Habanero::SlugIngredient.new(:name => 'Slug', :target => @sorbet.ingredients.first)

    # make sure we extend friendly_id
    @sorbet.chill!
    @sorbet.klass.new.should respond_to :friendly_id

    # make sure we can create and get back records using a slug
    record = @sorbet.klass.create(:foo => 'Bar')
    record.should be_persisted
    record.friendly_id.should == 'bar'
    record.slug.should == 'bar'
    record.to_param.should == 'bar'
    @sorbet.klass.find('bar').should == record

    # dupe friendly id
    record2 = @sorbet.klass.create(:foo => 'Bar')
    record.friendly_id.should_not == record2.friendly_id

    index = ActiveRecord::Base.connection.indexes(@sorbet.table_name).detect { |i| "index_#{@sorbet.table_name}_on_slug" }
    index.should_not be_nil
    index.unique.should be_true

    # cleanup
    @sorbet.ingredients.last.destroy
  end

  it 'should not create a unique index for scoped slugs' do
    @sorbet.ingredients << Habanero::SlugIngredient.new(:name => 'Sluggy', :target => @sorbet.ingredients.first, :scope => @sorbet.ingredients.last)

    record = @sorbet.klass.create(:foo => 'Bar', :site => Habanero::Site.new)
    record.should be_persisted
    record.friendly_id.should == 'bar'
    record.slug.should == 'bar'
    record.to_param.should == 'bar'
    @sorbet.klass.find('bar').should == record

    record2 = @sorbet.klass.create(:foo => 'Bar', :site => Habanero::Site.new)
    record.friendly_id.should == record2.friendly_id

    index = ActiveRecord::Base.connection.indexes(@sorbet.table_name).detect { |i| "index_#{@sorbet.table_name}_on_slug" }
    index.should_not be_nil
    index.unique.should be_false
  end
end
