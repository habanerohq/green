require 'spec_helper'

describe Habanero::Namespace do
  let(:namespace) { Habanero::Namespace.new :name => 'TestNamespace'}

  describe "structure" do
    let(:sorbet) { Habanero::Sorbet.new }

    it "has one or many sorbets" do
      namespace.sorbets << sorbet
      namespace.sorbets.last.should equal sorbet
    end

    it "has a unique name" do
      namespace.save!
      Habanero::Namespace.new(:name => 'TestNamespace').should_not be_valid
    end
  end
  
  describe "chilling" do
    it "defined a module for the namespace" do
      namespace.chill!
      defined?(TestNamespace).should_not be nil
    end
  end
end
