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

ActiveRecord::Schema[7.0].define(version: 2023_10_17_170406) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "occupation", default: "", null: false
    t.string "email", default: "", null: false
    t.string "age", default: "", null: false
    t.string "profile_image"
    t.string "question_1", default: "netflix", null: false
    t.string "question_2", default: "introvert", null: false
    t.string "question_3", default: "maybe", null: false
    t.string "question_4", default: "money", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question_5", default: "physical_touch", null: false
    t.string "generated_profile_img_url"
    t.string "ip_address"
  end

end
