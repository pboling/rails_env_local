# RailsEnvLocal

`rails_env_local`, where a rails environment for local development can be anything it desires.  Even a `butterfly`.  Tell your DevOps friends.

[Rails Guides](http://guides.rubyonrails.org/initialization.html) has more information on the Rails initialization routines.  You can easily accomplish what this gem does in a few lines of code.

... But are you going to write specs for code in your `config/boot.rb` file?  Really?


| Project                 |  FlagShihTzu      |
|------------------------ | ----------------- |
| gem name                |  rails_env_local    |
| license                 |  MIT              |
| version                 |  [![Gem Version](https://badge.fury.io/rb/rails_env_local.png)](http://badge.fury.io/rb/rails_env_local) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/pboling/rails_env_local.png)](https://gemnasium.com/pboling/rails_env_local) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/pboling/rails_env_local.png)](https://codeclimate.com/github/pboling/rails_env_local) |
| inline documenation     |  [![Inline docs](http://inch-ci.org/github/pboling/rails_env_local.png)](http://inch-ci.org/github/pboling/rails_env_local) |
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/pboling/rails_env_local.png?branch=master)](https://travis-ci.org/pboling/rails_env_local) |
| homepage                |  [on github](https://github.com/pboling/rails_env_local) |
| documentation           |  [on rdoc.info](http://rdoc.info/github/pboling/rails_env_local/frames) |
| author                  |  [Peter Boling](https://coderbits.com/pboling) |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  always |


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_env_local', require: false
```

`require: false` because we want to control when it is loaded.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_env_local

## Usage

In config/boot.rb you have:

    require 'bundler/setup'

After that line (or before, see NOTE below) add:

    require 'rails_env_local'
    RailsEnvLocal.set_local_environment

NOTE: If you need your custom local environment to be set before some of the other gems you use, because they rely on the environment being set early, then just place the two lines above *before* the `require 'bundler/setup'`.  Simple as that.

## Compatibility

This gem works with any version of Rails that uses `Rails.env`, *but* it is only tested with Rails 3.2, 4.1, 4.2, and 5.0.

This gem is tested with Ruby 2.2-latest and 2.3-latest.  It should work with any version of Ruby that supports both Ruby 1.9 hashes and double splat arguments.

## Theory

### Q: Why not just "local" as the default?

A: It is too generic.  "local" is often used in the same ordinal position as, but with a different meaning than, the environment name.  For one example of this see: https://github.com/bkeepers/dotenv#multiple-rails-environments

### Q: Why not just hand roll this when you need it?  Only a few lines of code.

A: Doing it right requires remembering a number of things that are easily forgotten since this is a set it and forget it type configuration.  If you don't start a new project every week, you may lose details on how to properly override the RAILS_ENV for local development (e.g. you may forget that naming it "local" is a bad idea and consequently break the `dotenv` gem).  Also if you have a large team you may not want to force them all to add an `export RAILS_ENV=localdev` statement to their shell profile.

### Q: Using this gem takes over the "development" environment namespace to be something else, so it precludes using "development" as a deployed environment. 

A: Yeah, pretty much.  Name your deployed environment "dev", "develop", or "anything_else".  Naming your deployed environment "development", when "development" is universally understood to be local development in Rails, is a recipe for confusion.

### Options:

#### `environment`
  * Type: a string
  * Default: `"localdev"`
  * Effect: Sets the Rails environment (`Rails.env`) to the given string
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(environment: "panda")
```

#### `verbose`
  * Type: boolean
  * Default: `false`
  * Effect: Prints the environment to `STDOUT` as it is being set
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(verbose: true)
```

#### `set_rack_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RAILS_ENV"]` to match `Rails.env`
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(set_rack_env: false)
```

#### `set_rails_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RACK_ENV"]` to match `Rails.env`
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(set_rails_env: false)
```

#### `force`
  * Type: boolean
  * Default: `false`
  * Effect: Setting `Rails.env`, no matter what, and `RAILS_ENV` / `RACK_ENV` variables according to other options given.
  * Example:
```ruby
    RailsEnvLocal.set_local_environment(force: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run a single suite of tests, or run `wwtd` to run all specs like TravisCI would. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Authors

[Peter Boling][mygithub], and ideally there would be some [contributors][contributors].

Find out more about Peter Boling's work at [RailsBling.com][railsbling]

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/rails_env_local.

To add your own ideas to this code base:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
6. Create new Pull Request


## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency 'rails_env_local', '~> 0.1'
```

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[mygithub]: http://github.com/pboling
[contributors]: https://github.com/pboling/rails_env_local/contributors