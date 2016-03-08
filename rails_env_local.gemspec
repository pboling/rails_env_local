# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_env_local/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_env_local"
  spec.version       = RailsEnvLocal::VERSION
  spec.licenses      = ["MIT"]
  spec.authors       = ["Peter Boling"]
  spec.email         = ["peter.boling@gmail.com"]

  spec.summary       = %q{"development" is not always the best name for the local environment}
  spec.description   = <<EODESC
  "development" is not always the best name for the local environment.
  Sometimes an alternate environment name, like "local", makes sense,
  and "dev", or "develop" may be used as a deployed environment.
EODESC
  spec.homepage      = "https://github.com/pboling/rails_env_local"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rails"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.5"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "appraisal", "~> 2.1"
  spec.add_development_dependency "wwtd", "~> 1.3"
end
