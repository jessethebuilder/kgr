class CreateTalentFors < ActiveRecord::Migration
  def change
    create_table :talent_fors do |t|
      t.integer :show_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
