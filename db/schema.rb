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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101003172516) do

  create_table "dummies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "age"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searchable_items", :force => true do |t|
    t.string   "searchable_model"
    t.string   "searchable_field"
    t.string   "searchable_field_type"
    t.integer  "searchable_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
