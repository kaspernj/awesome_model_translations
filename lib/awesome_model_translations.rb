require "awesome_model_translations/version"
require "awesome_model_translations/engine"
require "globalize_current_translation"

module AwesomeModelTranslations
  autoload :ModelExtensions, "#{__dir__}/awesome_model_translations/model_extensions"
  autoload :Translation, "#{__dir__}/awesome_model_translations/translation"
end
