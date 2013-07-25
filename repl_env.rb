require 'learndot'

unicorn = Learndot::Unicorn.new :local => true
org = unicorn.organization
course = org.courses.first
