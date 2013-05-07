require_relative '../../spec_helper'

describe Learndot::Records::User do

  before(:each) do
    @unicorn = Learndot::Unicorn.new :learndot_url => TEST_URL, :api_key => TEST_API_KEY
    @organization = @unicorn.organization
  end

  it 'should allow the creation of a user' do
    user = Learndot::Records::User.new(@unicorn)
    user.first_name = anonymous_string
    user.last_name = anonymous_string
    user.password = 'learndot'
    user.email = "joe+#{anonymous_string(10)}@learndot.com"
    user.save!

    course = Learndot::Records::Course.new(@unicorn)
    course.organization = @organization
    course.custom_order = false
    course.name = 'Test Course'
    course.description = 'Test'
    course.save!

    @organization.add_user(user)
    course.add_student(user)
  end

end