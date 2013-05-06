require_relative '../../spec_helper'

describe Learndot::Records::Course do

  before(:each) do
    @unicorn = Learndot::Unicorn.new :learndot_url => TEST_URL, :api_key => TEST_API_KEY
    @organization = @unicorn.organization
  end

  it "should allow the creation of a course" do

    course = Learndot::Records::Course.new(@unicorn)
    course.organization_id = @organization.id

    course.name = 'Test'
    course.description = '<p>Test<br/></p>'
    course.custom_order = false
    course.save

    new_course = Learndot::Records::Course.find(@unicorn, id: course.id)
    new_course.name.should eq course.name
    new_course.description.should eq course.description
    new_course.id.should eq course.id
    @@last_id = new_course.id
  end

  it 'should allow updating a course' do
    course= Learndot::Records::Course.find(@unicorn, id: @@last_id)
    course.name = 'A new an exciting name'
    course.save

    new_course = Learndot::Records::Course.find(@unicorn, id: course.id)
    new_course.name.should eq course.name
  end

  it 'should belong to an organization' do
    course= Learndot::Records::Course.find(@unicorn, id: @@last_id)

    course.organization.id.should eq @organization.id

    new_course= Learndot::Records::Course.new(@unicorn)
    new_course.organization = @organization

    new_course.organization_id.should eq @organization.id
  end


  it 'should allow deleting of a course' do
    course= Learndot::Records::Course.find(@unicorn, id: @@last_id)
    course.destroy!

    course.destroyed?.should eq true
    expect{ Learndot::Records::Course.find(@unicorn, id: course.id)}.to raise_error(Learndot::Errors::NotAuthorizedError)
  end
end