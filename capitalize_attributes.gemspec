require_relative 'lib/capitalize_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "capitalize_attributes"
  spec.version       = CapitalizeAttributes::VERSION
  spec.authors       = ["Mark Oveson"]
  spec.email         = ["mark.oveson@gmail.com"]

  spec.summary       = %q{Automatically capitalizes names and place-names.}
  spec.description   = %q{An ActiveModel extension that provides automatic capitalization for name and place-name attributes.}
  spec.homepage      = "https://www.github.com/moveson/capitalize_attributes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/moveson/capitalize_attributes/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 5.0"
  spec.add_development_dependency "rspec", "~> 3.9"
end
