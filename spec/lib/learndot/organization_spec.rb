require_relative '../../spec_helper'

describe Learndot::Records::Organization do

  before(:each) do
    @unicorn = Learndot::Unicorn.new :learndot_url => TEST_URL, :api_key => TEST_API_KEY
    @organization = @unicorn.organization
  end

  it 'should validate presence of app_name' do
    @organization.valid?.should be_true
    @organization.app_name = ''
    @organization.valid?.should be_false
  end

  it 'should validate presence of name' do
    @organization.valid?.should be_true
    @organization.name = ''
    @organization.valid?.should be_false
  end

  it 'should validate presence of host_url' do
    @organization.valid?.should be_true
    @organization.host_url = ''
    @organization.valid?.should be_false
  end
end