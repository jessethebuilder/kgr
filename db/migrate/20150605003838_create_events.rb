class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :keywords
      t.datetime :start_time
      t.string :main_image
      t.text :djs_attending, default: []

      t.string :facebook_event_link
      t.string :slug
      t.timestamps null: false
    end
  end
end
