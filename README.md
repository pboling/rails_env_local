# RailsEnvLocal

`rails_env_local`, where a rails environment for local development can be anything it desires.  Even a `butterfly`.  Tell your DevOps friends.

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

This gem can should work with any version of Rails that uses `Rails.env`, but it is only tested with Rails 3.2, 4.1, 4.2, and 5.0.

This gem is tested with Ruby 2.2-latest and 2.3-latest.  It should work with any version of Ruby that supports both Ruby 1.9 hashes and double splat arguments.

### Options:

#### `environment`
  * Type: a string
  * Default: `"local"`
  * Effect: Sets the Rails environment (`Rails.env`) to the given string
  * Example:
    
        RailsEnvLocal.set_local_environment(environment: "panda")

#### `verbose`
  * Type: boolean
  * Default: `false`
  * Effect: Prints the environment to `STDOUT` as it is being set
  * Example:

        RailsEnvLocal.set_local_environment(verbose: true)

#### `set_rack_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RAILS_ENV"]` to match `Rails.env`
  * Example:

        RailsEnvLocal.set_local_environment(set_rack_env: false)

#### `set_rails_env`
  * Type: boolean
  * Default: `true`
  * Effect: In addition to setting `Rails.env`, will set `ENV["RACK_ENV"]` to match `Rails.env`
  * Example:

        RailsEnvLocal.set_local_environment(set_rails_env: false)

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
[contributors]: https://github.com/pboling/flag_shih_tzu/contributors