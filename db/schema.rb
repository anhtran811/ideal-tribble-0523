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

ActiveRecord::Schema.define(version: 2023_01_02_162222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.integer "age"
  end

  create_table "movie_actors", force: :cascade do |t|
    t.bigint "movie_id"
    t.bigint "actor_id"
    t.index ["actor_id"], name: "index_movie_actors_on_actor_id"
    t.index ["movie_id"], name: "index_movie_actors_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "creation_year"
    t.string "genre"
    t.bigint "studio_id"
    t.index ["studio_id"], name: "index_movies_on_studio_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.string "location"
  end

  add_foreign_key "movie_actors", "actors"
  add_foreign_key "movie_actors", "movies"
  add_foreign_key "movies", "studios"
end
