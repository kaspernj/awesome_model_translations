require "rails_helper"

describe AwesomeModelTranslations::Sluggable do
  let(:page) do
    create :page,
      name_da: "Danish name",
      slug_da: "danish-name",
      name_de: "German name",
      slug_de: "german-name",
      name_en: "English name",
      slug_en: "english-name"
  end

  it "creates localized slugs" do
    expect { page }.to change(AwesomeModelTranslations::Slug, :count).by(3)

    danish_slug = page.friendly_id_slugs.find_by!(locale: "da")
    german_slug = page.friendly_id_slugs.find_by!(locale: "de")
    english_slug = page.friendly_id_slugs.find_by!(locale: "en")

    expect(danish_slug).to have_attributes(
      slug: "danish-name",
      sluggable_id: page.id,
      sluggable_type: "Page"
    )
    expect(german_slug).to have_attributes(
      slug: "german-name",
      sluggable_id: page.id,
      sluggable_type: "Page"
    )
    expect(english_slug).to have_attributes(
      slug: "english-name",
      sluggable_id: page.id,
      sluggable_type: "Page"
    )

    # It creates new slugs when updated
    expect { page.update!(slug_da: "New danish name", slug_de: "New german name", slug_en: "New english name") }
      .to change(AwesomeModelTranslations::Slug, :count).by(3)

    # It only creates new slug for changed values
    expect { page.update!(slug_da: "New new danish name", slug_de: "New german name", slug_en: "New english name") }
      .to change(AwesomeModelTranslations::Slug, :count).by(1)
  end
end
