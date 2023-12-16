require "rails_helper"

describe AwesomeModelTranslations::CurrentTranslationScope do
  let!(:female_gender) { create :gender, :female }
  let!(:male_gender) { create :gender, :male }
  let!(:other_gender) { create :gender, :other }

  it "creates a relationship that uses the current locale" do
    I18n.with_locale(:da) do
      found_danish_genders = Gender.left_joins(:current_translation).order("gender_translations.name")
      expect(found_danish_genders.map(&:name)).to eq ["Andet", "Kvinde", "Mand"]
    end

    I18n.with_locale(:en) do
      found_english_genders = Gender.left_joins(:current_translation).order("gender_translations.name")
      expect(found_english_genders.map(&:name)).to eq ["Female", "Male", "Other"]
    end
  end
end
