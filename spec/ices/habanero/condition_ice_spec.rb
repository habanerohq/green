require 'spec_helper'

describe Habanero::Condition do
  it { should belong_to(:query) }
  it { should belong_to(:ingredient) }

  it 'should allow valid values for predicate' do
    %w(eq not_eq matches does_not_match lt lteq gt gteq in not_in).each { |v| should allow_value(v).for(:predicate) }
  end

  it 'should now allow invalid values for predicate' do
    should_not allow_value('equals').for(:predicate)
  end
end
