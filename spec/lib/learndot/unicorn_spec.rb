require_relative '../../spec_helper'

describe Learndot::Unicorn do

  before(:all) do
    @learndot_url = "staging.learndot.com"

    Learndot::Unicorn.learndot_url = @learndot_url
    Learndot::Unicorn.api_key = "VzpehxD3l6QtTvBNm8Bz1Qbz6_d8BcA6Ypo7KhNHRP0"

    @unicorn = Learndot::Unicorn.new
  end

  #it "should generate the correct base uri" do
  #  Learndot::Unicorn.base_uri.should eq "http://#{@learndot_url}"
  #end

  it "should get the correct organization" do
    org = @unicorn.organization
    org.id.should eq 42
    puts org.as_json(root: false)
    org.app_name.should eq 'Learndot Integration Testing'
    org.name.should eq 'Learndot Integration Testing'
    org.host_url.should eq 'integration-testing.learndot.com'
  end

end