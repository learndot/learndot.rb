require_relative '../../spec_helper'

describe Learndot::Records::UnicornRecord do

  before(:all) do
    @unicorn = Learndot::Unicorn.new :learndot_url => @learndot_url, :api_key => TEST_API_KEY
  end

end