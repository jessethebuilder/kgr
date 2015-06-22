class CreateDjs < ActiveRecord::Migration
  def change
    create_table :djs do |t|
      t.string :name
      t.text :bio
      t.string :short_bio
      t.text :keywords
      t.string :head_shot
      t.string :slug
      t.string :tag_line
      t.string :facebook_url
      t.string :twitter_url
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
