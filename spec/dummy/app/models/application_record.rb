class ApplicationRecord < ActiveRecord::Base
  include AwesomeModelTranslations::ModelExtensions

  primary_abstract_class
end
