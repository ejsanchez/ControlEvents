# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 30) do

  create_table "activities", :force => true do |t|
    t.string   "name",                                       :null => false
    t.text     "description",                                :null => false
    t.string   "person_reg"
    t.string   "person_responsable"
    t.string   "email_contact"
    t.string   "phone_contact"
    t.integer  "activity_type_id",                           :null => false
    t.integer  "reservations_num",   :default => 1,          :null => false
    t.string   "opening",            :default => "interno",  :null => false
    t.string   "reach",              :default => "nacional", :null => false
    t.string   "url"
    t.string   "password",                                   :null => false
    t.integer  "status",             :default => 1
    t.string   "applicant_ip",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "observations"
    t.integer  "area_id"
    t.integer  "assistants_num"
    t.boolean  "published",          :default => false
    t.text     "participants",                               :null => false
    t.text     "institutions",                               :null => false
    t.integer  "num_asses",          :default => 0
    t.date     "begin_date"
    t.date     "finish_date"
    t.string   "project_name"
    t.date     "assess_date"
  end

  add_index "activities", ["name"], :name => "index_activities_on_name", :unique => true

  create_table "activity_types", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "activity_types", ["name"], :name => "index_activity_types_on_name", :unique => true

  create_table "advance_days", :force => true do |t|
    t.integer  "days",         :null => false
    t.string   "applicant_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "areas", ["name"], :name => "index_areas_on_name", :unique => true

  create_table "assigments", :force => true do |t|
    t.integer  "space_id",     :null => false
    t.integer  "manager_id",   :null => false
    t.string   "applicant_ip", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "assigments", ["space_id", "manager_id"], :name => "index_assigments_on_space_id_and_manager_id", :unique => true

  create_table "grantings", :force => true do |t|
    t.integer  "activity_type_id", :null => false
    t.integer  "service_id",       :null => false
    t.string   "applicant_ip",     :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "grantings", ["activity_type_id", "service_id"], :name => "index_grantings_on_activity_type_id_and_service_id", :unique => true

  create_table "holidays", :force => true do |t|
    t.date     "app_date",     :null => false
    t.date     "app_date_end"
    t.string   "applicant_ip", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "holidays", ["app_date"], :name => "index_holidays_on_app_date", :unique => true

  create_table "managers", :force => true do |t|
    t.string  "first_name",                 :null => false
    t.string  "last_name",                  :null => false
    t.string  "maiden_name"
    t.string  "login"
    t.string  "password"
    t.string  "location"
    t.string  "phone",                      :null => false
    t.string  "email",                      :null => false
    t.integer "role",        :default => 1
  end

  add_index "managers", ["login"], :name => "index_managers_on_login", :unique => true

  create_table "old_activities", :id => false, :force => true do |t|
    t.integer  "id",                                         :null => false
    t.string   "name"
    t.text     "description"
    t.string   "person_reg"
    t.string   "person_responsable"
    t.string   "email_contact"
    t.string   "phone_contact"
    t.integer  "activity_type_id"
    t.integer  "reservations_num",   :default => 1
    t.integer  "assistants_num"
    t.string   "opening",            :default => "interno"
    t.string   "reach",              :default => "nacional"
    t.string   "url"
    t.string   "password",                                   :null => false
    t.integer  "status",             :default => 1
    t.string   "observations"
    t.integer  "area_id"
    t.boolean  "published",          :default => false
    t.text     "participants"
    t.text     "institutions"
    t.string   "applicant_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_asses",          :default => 0
  end

  create_table "old_reservations", :id => false, :force => true do |t|
    t.integer  "id",                                      :null => false
    t.integer  "activity_id"
    t.integer  "space_id"
    t.integer  "status",          :default => 1
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "schedule",        :default => "matutino"
    t.text     "details"
    t.integer  "assistants_num"
    t.integer  "num_rapporteurs", :default => 0
    t.string   "applicant_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "space_id"
    t.integer  "status",          :default => 1
    t.date     "start_date",                              :null => false
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "schedule",        :default => "matutino"
    t.text     "details"
    t.string   "applicant_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assistants_num"
    t.integer  "num_rapporteurs", :default => 0
  end

  add_index "reservations", ["activity_id", "space_id", "start_date", "start_time", "end_time", "status"], :name => "by_activity_key", :unique => true

  create_table "services", :force => true do |t|
    t.string   "name",           :null => false
    t.integer  "servicetype_id", :null => false
    t.text     "details"
    t.string   "applicant_ip",   :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "priority"
  end

  add_index "services", ["name"], :name => "index_services_on_name", :unique => true

  create_table "servicetypes", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "servicetypes", ["name"], :name => "index_servicetypes_on_name", :unique => true

  create_table "signs", :force => true do |t|
    t.integer  "activity_id",  :null => false
    t.string   "sign",         :null => false
    t.string   "applicant_ip", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "signs", ["activity_id"], :name => "index_signs_on_activity_id", :unique => true

  create_table "spaces", :force => true do |t|
    t.string  "name",         :null => false
    t.integer "max_people",   :null => false
    t.string  "location"
    t.integer "manager_id",   :null => false
    t.string  "organization"
  end

  add_index "spaces", ["name"], :name => "index_spaces_on_name", :unique => true

  create_table "suppliers", :force => true do |t|
    t.string  "first_name",     :null => false
    t.string  "last_name",      :null => false
    t.string  "maiden_name"
    t.string  "location"
    t.integer "servicetype_id", :null => false
    t.string  "phone",          :null => false
    t.string  "email",          :null => false
  end

  add_index "suppliers", ["email"], :name => "index_suppliers_on_email", :unique => true

end
