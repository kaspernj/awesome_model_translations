require "rails_helper"

describe AwesomeModelTranslations::ModelExtensions do
  let(:project) { create :project, name_da: "Test projekt", name_en: "Test project" }

  describe "#changes" do
    it "tells what translated attributes has changed" do
      project.assign_attributes(
        name_da: "Nyt dansk navn",
        name_en: "New english name"
      )
      expect(project.changes).to eq(
        "name_da" => ["Test projekt", "Nyt dansk navn"],
        "name_en" => ["Test project", "New english name"]
      )
    end

    it "works when nothing has been changed" do
      expect(project.changes).to eq({})
    end

    it "works when no translations has been changed" do
      original_id = project.id
      project.assign_attributes(id: 5)
      expect(project.changes).to eq(
        "id" => [original_id, 5]
      )
    end
  end

  describe "#globalized_model" do
    it "returns the parent model" do
      danish_translation = project.translations.find { |translation| translation.locale == "da" }

      expect(danish_translation.globalized_model).to eq project
    end
  end

  describe "#translated_attribute_names" do
    it "returns a list of names" do
      expect(Project.translated_attribute_names).to eq [:name]
    end
  end
end
