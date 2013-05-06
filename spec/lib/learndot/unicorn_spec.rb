require_relative '../../spec_helper'

describe Learndot::Unicorn do

  before(:all) do
    @learndot_url = TEST_URL
    @unicorn = Learndot::Unicorn.new :learndot_url => @learndot_url, :api_key => TEST_API_KEY
  end

  it 'should generate the correct base uri' do
    Learndot::Unicorn.base_uri.should eq "https://#{@learndot_url}/api"
  end

  it 'should throw an exception when the API key is bad.' do
    @unicorn = Learndot::Unicorn.new :learndot_url => @learndot_url, :api_key => 'thisisbunk'
    expect { @unicorn.organization}.to raise_error(Learndot::Errors::BadApiKeyError)
  end

  it 'should get the correct organization' do
    org = @unicorn.organization
    org.id.should eq 42
    org.app_name.should eq 'Learndot Integration Testing'
    org.name.should eq 'Learndot Integration Testing'
  end

end