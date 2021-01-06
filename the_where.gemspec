require_relative 'lib/the_where/version'

Gem::Specification.new do |spec|
  spec.name          = "the_where"
  spec.version       = TheWhere::VERSION
  spec.authors       = ["sai1024"]
  spec.email         = ["rubyer1993@gmail.com"]

  spec.summary       = "Simpler query for ruby"
  spec.description   = "Simpler query for ruby"
  spec.homepage      = "https://github.com/sai1024/the_where"
  spec.license       = "MIT"
  # spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "https://github.com/sai1024/the_where"
  # spec.metadata["changelog_uri"] = "https://github.com/sai1024/the_where/blob/main/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
