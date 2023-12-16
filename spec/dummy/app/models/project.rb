class Project < ApplicationRecord
  include AwesomeModelTranslations::Sluggable

  translates :name
end
