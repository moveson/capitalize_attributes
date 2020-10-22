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

## Testing

Capitalize Attributes comes with custom RSpec matchers. To make the matchers available in all your specs, 
include the following in your `rails_helper` file:
```ruby
require "capitalize_attributes/matchers"

RSpec.configure do |config|
  config.include CapitalizeAttributes::Matchers
end
```

Within your spec file, use the matchers like this:
```ruby
RSpec.describe MyModel do
  it { is_expected.to capitalize_attribute(:first_name) }
  it { is_expected.to capitalize_attribute(:last_name) }
  it { is_expected.not_to capitalize_attribute(:password) }
end
```

### Testing in conjunction with the `strip_attributes` gem

The matchers provided with the `strip_attributes` gem are incompatible with this gem. To solve compatibility 
problems, you can monkey-patch the matchers by placing the following inside your RSpec support folder:
```ruby
# spec/support/matchers/strip_attributes.rb

# Monkey patch to get StripAttributes working with Titleizable module
module StripAttributes
  module Matchers
    class StripAttributeMatcher
      def matches?(subject)
        @attributes.all? do |attribute|
          @attribute = attribute
          subject.send("#{@attribute}=", " string ")
          subject.valid?
          subject.send(@attribute).downcase == "string" and collapse_spaces?(subject)
        end
      end

      private

      def collapse_spaces?(subject)
        return true if !@options[:collapse_spaces]

        subject.send("#{@attribute}=", " string    string ")
        subject.valid?
        subject.send(@attribute).downcase == "string string"
      end
    end
  end
end
```
This patch works with `strip_attributes` version 1.11.0. The only changes from the code in that gem 
are the additions of `.downcase` in lines 10 and 21.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moveson/capitalize_attributes.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
