class AddSaveDraftArchiveDeleteFieldsToShow < ActiveRecord::Migration
  def change
    add_column :shows, :archived, :boolean, default: false
    add_column :shows, :published, :boolean, default: false
  end
end
