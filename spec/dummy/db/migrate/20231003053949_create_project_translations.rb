class CreateProjectTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :project_translations do |t|
      t.references :project, foreign_key: true, null: false
      t.string :locale, null: false
      t.string :name
      t.timestamps
    end

    add_index :project_translations, [:project_id, :locale], unique: true
  end
end
