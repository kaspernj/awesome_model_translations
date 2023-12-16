# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_16_092051) do
  create_table "gender_translations", force: :cascade do |t|
    t.integer "gender_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["gender_id"], name: "index_gender_translations_on_gender_id"
    t.index ["locale"], name: "index_gender_translations_on_locale"
  end

  create_table "genders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_translations", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "locale", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "locale"], name: "index_project_translations_on_project_id_and_locale", unique: true
    t.index ["project_id"], name: "index_project_translations_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.string "scope"
    t.datetime "created_at"
    t.string "locale", null: false
    t.string "sluggable_type", null: false
    t.integer "sluggable_id", null: false
    t.index ["locale"], name: "index_slugs_on_locale"
    t.index ["slug", "sluggable_type", "locale"], name: "index_slugs_on_slug_and_sluggable_type_and_locale"
    t.index ["slug", "sluggable_type", "scope", "locale"], name: "index_slugs_uniqueness", unique: true
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id"
    t.index ["sluggable_type", "sluggable_id"], name: "index_slugs_on_sluggable"
    t.index ["sluggable_type"], name: "index_slugs_on_sluggable_type"
  end

  add_foreign_key "gender_translations", "genders"
  add_foreign_key "project_translations", "projects"
end
