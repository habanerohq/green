require 'spec_helper'

describe Habanero::AssociationTrait do
  before(:each) do
    @variety = Habanero::Variety.new(
      :name => 'AssocDummy',
      :parent => Habanero::Variety.branded('ActiveRecord').where(:name => 'Base').first,
      :brand => Habanero::Brand.find_by_name('Habanero'),
      :traits => [
        Habanero::StringTrait.new(:name => 'Foo')
      ]
    )

    # todo: don't use Habanero::Site to test the other side of the association

    @relation = Habanero::RelationTrait.create!(
      :name => 'Site Dummies',
      :variety => @variety,
      :ordered => true,
      :children => [
        Habanero::AssociationTrait.new(:name => 'Dummies', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Site')),
        Habanero::AssociationTrait.new(:name => 'Site', :relation => 'belongs_to', :variety => @variety),
      ]
    )

    @variety.save!
    @variety.chill!
  end

  after(:each) do
    Habanero.send :remove_const, 'AssocDummy'
    Habanero.send :remove_const, 'Site' if Habanero.constants.include?('Site')
  end

  it 'has an inverse' do
    @relation.children.first.inverse.should == @relation.children.last
    @relation.children.last.inverse.should == @relation.children.first
  end

  it 'is not polymorphic' do
    @relation.children.first.should_not be_polymorphic
    @relation.children.last.should_not be_polymorphic
  end

  it 'knows if columns are required' do
    @relation.children.first.should_not be_columns_required
    @relation.children.last.should be_columns_required
  end

  it 'has a column name, method name and position name' do
    @relation.children.first.method_name.should == 'dummies' 
    @relation.children.last.method_name.should == 'site'
    @relation.children.last.column_name.should == 'site_id'
    @relation.children.last.position_name.should == 'site_position'
  end

  it 'has a column type' do
    @relation.children.last.column_type.should == :integer
  end

  it 'builds has_many association' do 
    a = Habanero::Site.reflect_on_association(:dummies)
    a.should be_present
    a.class_name.should == '::Habanero::AssocDummy'
    a.foreign_key.should == 'site_id'
    a.options[:order].should == 'site_position'
    a.macro.should == :has_many
  end

  it 'builds belongs_to association' do 
    a = Habanero::AssocDummy.reflect_on_association(:site)
    a.should be_present
    a.class_name.should == '::Habanero::Site'
    a.macro.should == :belongs_to
  end

  it 'maintains columns in the variety database table' do
    ActiveRecord::Base.connection.columns(@variety.table_name).map(&:name).should include 'site_id'
    Habanero::AssocDummy.new.should respond_to 'site'

    ActiveRecord::Base.connection.columns(@variety.table_name).map(&:name).should include 'site_position'
    Habanero::AssocDummy.new.should respond_to 'site_position'

    Habanero::Site.new.should respond_to 'dummies'
  end

  it 'acts as list' do
    Habanero::AssocDummy.ancestors.should include ActiveRecord::Acts::List::InstanceMethods
  end

  it 'handles polymorphic associations' do
    poly = Habanero::RelationTrait.create!(
      :name => 'Context Dummies',
      :variety => @variety,
      :children => [
        Habanero::AssociationTrait.new(:name => 'Dummies', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Brand')),
        Habanero::AssociationTrait.new(:name => 'Dummies', :relation => 'has_many', :variety => Habanero::Variety.find_by_name('Layout')),
        Habanero::AssociationTrait.new(:name => 'Context', :relation => 'belongs_to', :variety => @variety)
      ]
    )

    poly.children.count.should == 3
    poly.children.each { |c| c.should be_polymorphic }

    a = Habanero::Brand.reflect_on_association(:dummies)
    a.should be_present
    a.class_name.should == '::Habanero::AssocDummy'
    a.options[:as].should == 'context'
    a.foreign_key.should == 'context_id'

    a = Habanero::Layout.reflect_on_association(:dummies)
    a.should be_present
    a.class_name.should == '::Habanero::AssocDummy'
    a.options[:as].should == 'context'
    a.foreign_key.should == 'context_id'

    a = Habanero::AssocDummy.reflect_on_association(:context)
    a.should be_present
    a.options[:polymorphic].should == true

    poly.destroy
  end
end
