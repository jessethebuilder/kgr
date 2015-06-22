class AddUserIdToDj < ActiveRecord::Migration
  def change
    add_column :djs, :user_id, :integer
  end
end
