class CreateGenders < ActiveRecord::Migration[6.0]
  def up
    create_table :genders do |t| # rubocop:disable Style/SymbolProc
      t.timestamps
    end

    create_table "gender_translations", force: :cascade do |t|
      t.integer "gender_id", null: false
      t.string "locale", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "name"
      t.index ["gender_id"], name: "index_gender_translations_on_gender_id"
      t.index ["locale"], name: "index_gender_translations_on_locale"
    end

    add_foreign_key :gender_translations, :genders
  end

  def down
    drop_table :gender_translations
    drop_table :genders
  end
end
