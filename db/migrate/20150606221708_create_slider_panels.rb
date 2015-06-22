class CreateSliderPanels < ActiveRecord::Migration
  def change
    create_table :slider_panels do |t|
      t.string :image
      t.string :slider_text
      t.integer :slider_includeable_id
      t.string :slider_includeable_type

      t.timestamps null: false
    end
  end
end
