require_relative '../../spec_helper'

describe Learndot::Records::Organization do

  before(:each) do
    @unicorn = Learndot::Unicorn.new :learndot_url => TEST_URL, :api_key => TEST_API_KEY
    @organization = @unicorn.organization
  end

  it "save it self" do

  end
end