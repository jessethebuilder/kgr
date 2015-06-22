class AddSaveDraftArchiveDeleteFieldsToEventAndDj < ActiveRecord::Migration
  def change
    add_column :events, :published, :boolean, default: false
    add_column :events, :archived, :boolean, default: false

    add_column :djs, :published, :boolean, default: false
    add_column :djs, :archived, :boolean, default: false
  end
end
