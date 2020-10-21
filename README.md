# Capitalize Attributes

Capitalize Attributes is an ActiveModel extension that can automatically capitalize names and place-names that were entered as all-lowercase or all-uppercase text. This is often the case when a user is asked to provide personal information such as name, state, city, or country in an input form.

Capitalize Attributes does not attempt to work magic on mixed-case text. If someone goes to the trouble of using the shift key at some point during input, we assume they know what they are doing. This gem only affects values that are entirely uppercase or entirely lowercase.

Capitalize Attributes works with ActiveRecord and ActiveModel models.

This gem was inspired by the workhorse `strip_attributes` gem: https://github.com/rmm5t/strip_attributes

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capitalize_attributes'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install capitalize_attributes

## Usage

To use this gem, include the gem and then list the attributes that should be capitalized, like this:

```ruby
class MyModel < ::ApplicationRecord
  include CapitalizeAttributes

  capitalize_attributes :first_name, :last_name, :city
end

=> record = MyModel.new(first_name: "whisper", last_name: "SHOUT", city: "McCall")
=> record.validate
=> record.first_name
#> "Whisper"
=> record.last_name
#> "Shout"
=> record.city
#> "McCall"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moveson/capitalize_attributes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
