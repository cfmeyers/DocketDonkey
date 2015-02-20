# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150220092639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cases", force: :cascade do |t|
    t.string   "case_number"
    t.integer  "case_number_integer"
    t.string   "title"
    t.string   "case_type"
    t.string   "case_status"
    t.date     "status_date"
    t.date     "file_date"
    t.string   "property_address"
    t.string   "plaintiff_name_original"
    t.string   "plaintiff_name_guess"
    t.string   "plaintiff_attorney_name"
    t.string   "defendants_json"
    t.boolean  "defendants_self_represented"
    t.string   "docket_information"
    t.string   "case_outcome"
    t.date     "case_outcome_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
