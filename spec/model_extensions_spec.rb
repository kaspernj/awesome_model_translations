require "rails_helper"

describe AwesomeModelTranslations::ModelExtensions do
  let(:project) { create :project, name_da: "Test projekt", name_en: "Test project" }

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
