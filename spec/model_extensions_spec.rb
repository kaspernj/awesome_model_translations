require "rails_helper"

describe AwesomeModelTranslations::ModelExtensions do
  describe "#translated_attribute_names" do
    it "returns a list of names" do
      expect(Project.translated_attribute_names).to eq [:name]
    end
  end
end
