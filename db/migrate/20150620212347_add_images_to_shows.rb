class AddImagesToShows < ActiveRecord::Migration
  def change
    add_column :shows, :main_image, :string
    add_column :shows, :slider_image, :string
  end
end
