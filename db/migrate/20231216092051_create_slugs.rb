class CreateSlugs < ActiveRecord::Migration[7.0]
  def change
    create_table "slugs" do |t|
      t.string "slug", null: false
      t.string "sluggable_type", limit: 50
      t.string "scope"
      t.datetime "created_at"
      t.string "locale", null: false
      t.string "sluggable_id", limit: 36, null: false
      t.index ["locale"], name: "index_friendly_id_slugs_on_locale"
      t.index ["slug", "sluggable_type", "locale"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_locale"
      t.index ["slug", "sluggable_type", "scope", "locale"], name: "index_friendly_id_slugs_uniqueness", unique: true
      t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
      t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
    end
  end
end
