# Learndot

An object wrapper for our HTTP API

## Installation

Add this line to your application's Gemfile:

    gem 'learndot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install learndot

## Usage

Create a unicorn object

```ruby

# use this syntax if your learndot url is of the form mycompany.learndot.com
unicorn = Unicorn.new :learndot_name => 'my-company', :api_key => 'my-api-key'

# use this syntax if your learndot url is of the form learn.mycompany.com or some other custom domain
unicorn = Unicorn.new :learndot_url => 'learn.mycompany.com', :api_key => 'my-api-key'
```

You can then access your organization and courses as follows:

```ruby

unicorn.organization # Your organization

organization.courses # All courses in your learndot

Course.find(unicorn) # All courses in your learndot

Course.find(5)       # A specific course in your learndot

```

You can also remotely create courses

```ruby

course = Course.new(unicorn)
course.organization = unicorn.organization
course.name = 'My Course Name'
course.description = '<p>My Greate Course</p>'
course.save!

```

Update them:

```ruby

course = Course.find(unicorn, 1)
course.name = 'My New Name'
course.description = '<p>My Greate Course</p>'
course.save!

```


Destroy them:

```ruby

course = Course.find(unicorn, 1)
course.destroy!

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request