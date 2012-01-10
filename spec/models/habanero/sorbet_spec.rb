require 'spec_helper'

describe Habanero::Sorbet do
  describe "structure" do
    let(:sorbet) { Habanero::Sorbet.new }
    let(:ingredient) { Habanero::Ingredient.new }
    let(:namespace) { Habanero::Namespace.new }

    it "has many ingredients" do
      sorbet.ingredients << ingredient
      sorbet.ingredients.last.should equal ingredient
    end
    
    it "has a namespace" do
      sorbet.namespace = namespace
      sorbet.namespace.should equal namespace
    end
  end
end
