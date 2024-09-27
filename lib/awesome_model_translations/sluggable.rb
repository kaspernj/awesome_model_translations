module AwesomeModelTranslations::Sluggable
  def self.included(base)
    base.extend ClassMethods
    base.has_many :slugs, as: :sluggable, class_name: "AwesomeModelTranslations::Slug", dependent: :destroy
    base.after_save :__set_slug

    base.scope :where_current_slug, lambda { |slug|
      joins(:slugs)
        .where(slugs: {locale: I18n.locale}).where("slugs.slug = :slug OR #{table_name}.id = :slug", slug:)
    }
  end

  module ClassMethods
    def find_by_sluggable!(param)
      return find(param) if UuidTester.uuid?(param)

      locales = I18n.fallbacks[I18n.locale]&.map(&:to_s) || [I18n.locale.to_]
      slugs = AwesomeModelTranslations::Slug
        .select(:locale, :sluggable_id, :sluggable_type)
        .where(
          slug: param,
          sluggable_type: name
        )
        .to_a

      locales.each do |locale|
        slug_with_locale = slugs.find { |slug| slug.locale == locale }

        return slug_with_locale.sluggable if slug_with_locale
      end

      raise ActiveRecord::RecordNotFound, "No #{name} found with that slug: #{param}"
    end
  end

  def __current_slug
    locales = I18n.fallbacks[I18n.locale].map(&:to_s) || [I18n.locale.to_s]
    slugs_to_check = slugs.to_a.sort_by(&:created_at).reverse

    locales.each do |locale|
      slug_with_locale = slugs_to_check.find { |slug| slug.locale == locale }

      return slug_with_locale.slug if slug_with_locale
    end

    id
  end

  def __generate_slug
    name_for_slug = if respond_to?(:sluggable_slug, true) && sluggable_slug.present?
      sluggable_slug
    elsif name.present?
      name
    end

    return nil if name_for_slug.blank?

    name_for_slug.downcase.gsub(/(\s+|\/)/, "-")
  end

  def __set_slug
    I18n.available_locales.each do |locale|
      I18n.with_locale(locale) do
        slug = __generate_slug

        next if slug.blank?

        slugs.find_or_create_by!(locale:, slug:)
      end
    end
  end

  def slug
    __current_slug
  end

  def to_param
    __current_slug
  end
end
