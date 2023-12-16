require "rails_helper"

describe AwesomeModelTranslations::Sluggable do
  let(:project) do
    create :project,
      name_da: "Danish name",
      name_de: "German name",
      name_en: "English name"
  end

  it "creates localized slugs" do
    expect { project }.to change(AwesomeModelTranslations::Slug, :count).by(3)

    danish_slug = project.slugs.find_by!(locale: "da")
    german_slug = project.slugs.find_by!(locale: "de")
    english_slug = project.slugs.find_by!(locale: "en")

    expect(danish_slug).to have_attributes(
      slug: "danish-name",
      sluggable_id: project.id,
      sluggable_type: "Project"
    )
    expect(german_slug).to have_attributes(
      slug: "german-name",
      sluggable_id: project.id,
      sluggable_type: "Project"
    )
    expect(english_slug).to have_attributes(
      slug: "english-name",
      sluggable_id: project.id,
      sluggable_type: "Project"
    )

    # It creates new slugs when updated
    expect { project.update!(name_da: "New danish name", name_de: "New german name", name_en: "New english name") }
      .to change(AwesomeModelTranslations::Slug, :count).by(3)

    # It only creates new slug for changed values
    expect { project.update!(name_da: "New new danish name", name_de: "New german name", name_en: "New english name") }
      .to change(AwesomeModelTranslations::Slug, :count).by(1)

    # It returns the expected slug for the current locale
    I18n.with_locale(:da) { expect(project).to have_attributes(name: "New new danish name") }
    I18n.with_locale(:de) { expect(project).to have_attributes(name: "New german name") }
    I18n.with_locale(:en) { expect(project).to have_attributes(name: "New english name") }
  end
end
