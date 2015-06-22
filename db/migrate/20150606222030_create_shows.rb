class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.text :description

      t.integer :dj_id

      t.timestamps null: false
    end
  end
end
