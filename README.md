# Standalone RSpec + Capybara

## Project Layout

* `spec/integration/*_spec.rb` : RSpec Scenario
* `spec/spec_helper.rb` : Configure the Test suite
* `spec/support/` : Additional Helpers
* `spec/fixtures/` : YAML files you can user as fixtures in your tests

## Prerequisites

* Ruby http://www.ruby-lang.org/en/downloads/
* Bundler: gem install bundler

## For Capybara-Webkit

If you want to use `capybara-webkit` (Github)[https://github.com/thoughtbot/capybara-webkit] Please install Qt first. On OSX:

    brew update
    brew install qt

And uncomment this lines:

    # gem "capybara-webkit"    # in Gemfile:9
    
    # require "capybara/webkit"     # in spec/spec_helper.rb:9

Finally, configure Capybara to use webkit:

    capybara.default_driver = :webkit    # in spec/spec_helper.rb:54

## Configuration

Install Gems:
    
    bundle install

## Running Features

To run all features: 

    bundle exec rake

To run a specific feature: 

    bundle exec rake spec:search

See [Single Test](https://github.com/grosser/single_test) for examples.

## Using fixtures

`$data` is the global variable. It's an object. Each method is a file in `spec/fixtures/`. For example, you have the file `spec/fixtures/user1.yml`, which contains an attribute (`name`).
You can access this data everywhere with:

    name = $data.user1.name

The pattern:

    one_value = $data.file_name.value

## Additional Links

* http://relishapp.com/rspec
* https://github.com/jnicklas/capybara
* https://github.com/LRDesign/rspec-steps