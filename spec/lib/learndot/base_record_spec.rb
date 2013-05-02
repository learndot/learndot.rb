require_relative '../../spec_helper'

class Test < Learndot::BaseRecord
  unicorn_attr :custom_attr
end

describe Learndot::BaseRecord do

  before(:all) do
    @obj = Test.new
  end

  it "should create accessors" do
    @obj.respond_to?(:custom_attr).should eq(true)
    @obj.custom_attr = 'test'
    @obj.custom_attr.should eq('test')
  end

end
