require_relative "lib/awesome_model_translations/version"

Gem::Specification.new do |spec|
  spec.name        = "awesome_model_translations"
  spec.version     = AwesomeModelTranslations::VERSION
  spec.authors     = ["kaspernj"]
  spec.email       = ["kasper@diestoeckels.de"]
  spec.homepage    = "https://github.com/kaspernj/awesome_model_translations"
  spec.summary     = "Model translations for ActiveRecord."
  spec.description = "Model translations for ActiveRecord."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.3.5"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kaspernj/awesome_model_translations"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
