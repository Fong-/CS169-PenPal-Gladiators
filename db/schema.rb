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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150426202521) do

  create_table "arenas", :force => true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "arenas", ["user1_id"], :name => "index_arenas_on_user1_id"
  add_index "arenas", ["user2_id"], :name => "index_arenas_on_user2_id"

  create_table "conversations", :force => true do |t|
    t.string   "title"
    t.integer  "arena_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "conversations", ["arena_id"], :name => "index_conversations_on_arena_id"

  create_table "invites", :force => true do |t|
    t.integer "from_id"
    t.integer "to_id"
  end

  add_index "invites", ["from_id"], :name => "index_invites_on_from_id"
  add_index "invites", ["to_id"], :name => "index_invites_on_to_id"

  create_table "posts", :force => true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "posts", ["conversation_id"], :name => "index_posts_on_conversation_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "survey_questions", :force => true do |t|
    t.string   "text"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "index"
  end

  add_index "survey_questions", ["topic_id"], :name => "index_survey_questions_on_topic_id"

  create_table "survey_responses", :force => true do |t|
    t.string   "text"
    t.integer  "survey_question_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "index"
    t.string   "summary_text"
  end

  add_index "survey_responses", ["survey_question_id"], :name => "index_survey_responses_on_survey_question_id"

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_survey_responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_response_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "user_survey_responses", ["survey_response_id"], :name => "index_user_survey_responses_on_survey_response_id"
  add_index "user_survey_responses", ["user_id"], :name => "index_user_survey_responses_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "secret"
    t.string   "username"
    t.string   "avatar"
    t.text     "political_blurb"
    t.string   "political_hero"
    t.integer  "political_spectrum"
  end

end

