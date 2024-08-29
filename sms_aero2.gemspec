lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sms_aero2/version"

Gem::Specification.new do |spec|
  spec.name          = "sms_aero2"
  spec.version       = SmsAero2::VERSION
  spec.authors       = ["Alexander Shvaykin"]
  spec.email         = ["skiline.alex@gmail.com"]

  spec.summary       = %q{Simple gem for smsaero.ru API.}
  spec.homepage      = "https://teachbase.ru"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.5.10"
  spec.add_development_dependency "rake", "~> 13.2.1"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "webmock", ">= 3.23.1"
  spec.add_development_dependency "pry", "~> 0.14.2"
end
