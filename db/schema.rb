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

ActiveRecord::Schema.define(version: 2020_09_10_184017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "announcements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

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
    t.integer "decision", limit: 2, default: -2, null: false
    t.jsonb "decision_response"
    t.string "entity_id"
    t.string "evaluation_id"
    t.string "application_token"
    t.string "application_version_id"
    t.integer "processing_status", default: 0, null: false
    t.integer "status", default: 1, null: false
  end

  create_table "audits", force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.uuid "associated_id"
    t.string "associated_type"
    t.uuid "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
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

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "document_type"
    t.uuid "applicant_id", null: false
    t.integer "decision", limit: 2, default: -2, null: false
    t.jsonb "decision_response"
    t.string "entity_id"
    t.string "evaluation_id"
    t.string "application_token"
    t.string "application_version_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "processing_status", default: 0, null: false
    t.index ["applicant_id"], name: "index_documents_on_applicant_id"
  end

  create_table "line_item_decisions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "decision"
    t.uuid "decidable_id"
    t.string "decidable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sources", default: [], null: false, array: true
    t.index ["decidable_type", "decidable_id"], name: "index_line_item_decisions_on_decidable_type_and_decidable_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.uuid "applicant_id", null: false
    t.integer "status", null: false
    t.date "due_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_tasks_on_applicant_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "validations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "applicant_id", null: false
    t.string "type", null: false
    t.jsonb "input"
    t.jsonb "output"
    t.integer "status", default: 0, null: false
    t.integer "decision"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applicant_id"], name: "index_validations_on_applicant_id"
  end

  create_table "wage_verifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reported_employer_name"
    t.string "reported_employer_id"
    t.date "reported_termination_date"
    t.decimal "verified_wages"
    t.string "verified_employer_name"
    t.string "verified_employer_id"
    t.string "verified_time_period"
    t.date "verified_termination_date"
    t.string "truework_verification_status"
    t.string "verification_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "applicant_id"
    t.integer "decision", limit: 2
    t.decimal "reported_wages", default: "0.0", null: false
    t.string "reported_time_period", default: ""
    t.integer "processing_status", limit: 2, default: 0, null: false
    t.index ["applicant_id"], name: "index_wage_verifications_on_applicant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "documents", "applicants"
  add_foreign_key "tasks", "applicants"
end
