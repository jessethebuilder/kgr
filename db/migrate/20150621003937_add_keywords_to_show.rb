class AddKeywordsToShow < ActiveRecord::Migration
  def change
    add_column :shows, :keywords, :text
  end
end
