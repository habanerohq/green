require 'spec_helper'

describe Habanero::AssociationIngredient do

  before(:each) do
    @sorbet = Habanero::Sorbet.create!(
      :name => 'Dummy',
      :parent => Habanero::Sorbet.first, # ActiveRecord::Base
      :namespace => Habanero::Namespace.find_by_name('Habanero'),
      :ingredients => [
        Habanero::StringIngredient.new(:name => 'Foo')
      ]
    )

    @relation = Habanero::RelationIngredient.create!(
      :name => 'Site Dummies',
      :sorbet => @sorbet,
      :ordered => true,
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
    a.class_name.should == '::Habanero::Dummy'
    a.foreign_key.should == 'site_id'
    a.options[:order].should == 'site_position'
    a.macro.should == :has_many
  end
  
  it 'builds belongs_to association' do 
    a = Habanero::Dummy.reflect_on_association(:site)
    a.should be_present
    a.class_name.should == '::Habanero::Site'
    a.macro.should == :belongs_to
  end

  it 'maintains columns in the sorbet database table' do
    ActiveRecord::Base.connection.columns('habanero_dummies').map(&:name).should include 'site_id'
    Habanero::Dummy.new.should respond_to 'site'

    ActiveRecord::Base.connection.columns('habanero_dummies').map(&:name).should include 'site_position'
    Habanero::Dummy.new.should respond_to 'site_position'

    Habanero::Site.new.should respond_to 'dummies'
  end
  
  it 'acts as list' do
    Habanero::Dummy.ancestors.should include ActiveRecord::Acts::List::InstanceMethods
  end
  
  it 'handles polymorphic associations' do
    poly = Habanero::RelationIngredient.create!(
      :name => 'Context Dummies',
      :sorbet => @sorbet,
      :children => [
        Habanero::AssociationIngredient.new(:name => 'Dummies', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Namespace')),
        Habanero::AssociationIngredient.new(:name => 'Dummies', :relation => 'has_many', :sorbet => Habanero::Sorbet.find_by_name('Layout')),
        Habanero::AssociationIngredient.new(:name => 'Context', :relation => 'belongs_to', :sorbet => @sorbet)
      ]
    )
      
    poly.children.count.should == 3
    poly.children.each { |c| c.should be_polymorphic }
    
    a = Habanero::Namespace.reflect_on_association(:dummies)
    a.should be_present
    a.class_name.should == '::Habanero::Dummy'
    a.options[:as].should == 'context'
    a.foreign_key.should == 'context_id'
    
    a = Habanero::Layout.reflect_on_association(:dummies)
    a.should be_present
    a.class_name.should == '::Habanero::Dummy'
    a.options[:as].should == 'context'
    a.foreign_key.should == 'context_id'
    
    a = Habanero::Dummy.reflect_on_association(:context)
    a.should be_present
    a.options[:polymorphic].should == true
    
    poly.destroy
  end
end
