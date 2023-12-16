class AwesomeModelTranslations::Slug < AwesomeModelTranslations::ApplicationRecord
  self.table_name = "slugs"

  belongs_to :sluggable, polymorphic: true

  validates :slug, presence: true
end
