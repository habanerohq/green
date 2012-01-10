require 'spec_helper'

describe Habanero::Namespace do
  describe "structure" do
    let(:sorbet) { Habanero::Sorbet.new }
    let(:namespace) { Habanero::Namespace.new }

    it "has one or many sorbets" do
      namespace.sorbets << sorbet
      namespace.sorbets.last.should equal sorbet
    end
  end
end
