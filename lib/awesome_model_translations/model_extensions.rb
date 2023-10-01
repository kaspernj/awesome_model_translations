module AwesomeModelTranslations::ModelExtensions
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def translations(*attributes)
      class_name = "#{name}::Translation"
      translations_table_name = "#{table_name.singularize}_translations"

      translation_model_class = Class.new(AwesomeModelTranslations::Translation) do
        self.table_name = translations_table_name
      end

      translation_model_class.define_singleton_method(:name) do
        class_name
      end

      translation_model_class.belongs_to model_name.element.to_sym, inverse_of: :translations, optional: true

      const_set(:Translation, translation_model_class)

      has_many :translations, autosave: true, class_name:, dependent: :destroy

      define_method(:changed?) do |*args, &blk|
        super(*args, &blk) || translations.target.any?(&:changed?)
      end

      attributes.each do |attribute_name|
        attribute attribute_name.to_sym

        define_method(attribute_name) do
          fallbacks = I18n.fallbacks.fetch(I18n.locale)
          value = nil

          fallbacks.each do |locale|
            value = __send__("#{attribute_name}_#{locale}")

            break if value.present?
          end

          value
        end

        define_method("#{attribute_name}=") do |new_value|
          __send__("#{attribute_name}_#{I18n.locale}=", new_value)
        end

        I18n.available_locales.each do |locale|
          current_locale = locale.to_s

          define_method("#{attribute_name}_#{locale}") do
            translations.detect { |translation| translation.locale == current_locale }&.__send__(attribute_name)
          end

          define_method("#{attribute_name}_#{locale}=") do |new_value|
            translation = translations.detect { |translation_i| translation_i.locale == current_locale }
            translation ||= translations.build(locale: current_locale)
            old_value = translation.__send__(attribute_name)
            translation.assign_attributes(attribute_name => new_value)
            __send__(:attribute_will_change!, attribute_name) if old_value != new_value
          end
        end
      end

      include GlobalizeCurrentTranslation::Scope
    end
  end
end
