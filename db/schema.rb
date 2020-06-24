# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_18_170603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "applicants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", limit: 64
    t.string "last_name", limit: 64
    t.date "birthdate"
    t.string "email_address", limit: 128
    t.string "phone_number", limit: 32
    t.string "street_address", limit: 128
    t.string "city", limit: 64
    t.string "state", limit: 2
    t.string "postal_code", limit: 5
    t.string "ssn"
    t.string "case_number", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "descision"
    t.jsonb "descision_response"
    t.string "entity_id"
    t.string "evaluation_id"
    t.string "application_token"
    t.string "application_version_id"
  end

  create_table "bank_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "bank_account_number"
    t.string "bank_routing_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "decision"
    t.uuid "applicant_id"
    t.index ["applicant_id"], name: "index_bank_accounts_on_applicant_id"
  end

end
