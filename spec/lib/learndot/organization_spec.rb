require_relative '../../spec_helper'

describe Learndot::Organization do

  before(:all) do
    @learndot_url = "localhost:8080"
    Learndot::Unicorn.learndot_url = @learndot_url
    Learndot::Unicorn.api_key = "VzpehxD3l6QtTvBNm8Bz1Qbz6_d8BcA6Ypo7KhNHRP0"
    @unicorn = Learndot::Unicorn.new
    @organization = Learndot::Unicorn.new.organization
  end

  #it "should generate the correct base uri" do
  #  Learndot::Unicorn.base_uri.should eq "http://#{@learndot_url}"
  #end

  it "save it self" do
    @organization.welcome_message = 'an test'
    @organization.save
    @unicorn.organization.welcome_message.should be 'an test'
  end

end