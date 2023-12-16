require "awesome_model_translations/version"
require "awesome_model_translations/engine"

module AwesomeModelTranslations
  autoload :CurrentTranslationScope, "#{__dir__}/awesome_model_translations/current_translation_scope"
  autoload :ModelExtensions, "#{__dir__}/awesome_model_translations/model_extensions"
  autoload :Sluggable, "#{__dir__}/awesome_model_translations/sluggable"
  autoload :Translation, "#{__dir__}/awesome_model_translations/translation"
end
