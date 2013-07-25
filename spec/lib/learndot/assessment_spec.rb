require_relative '../../spec_helper'
require 'json'

describe Learndot::Records::Assessment do

  before(:all) do
    @unicorn = Learndot::Unicorn.new :local => true

    @organization = @unicorn.organization
    @concept = @organization.courses.first.concepts.first
  end

  it "describe" do

    path = "/Users/joe/learndot/Source/unicorn/learndot.rb/test_file.json"
    input_file = File.read(path)

    Learndot::Records::Concept.from_file @unicorn, input_file

    File.rename(path, path + "." + Time.new)

    output_file = File.open(path, 'w')

    output_file.write(@concept.describe_assessment_as_json)
  end

end