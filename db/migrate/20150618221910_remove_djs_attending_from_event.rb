class RemoveDjsAttendingFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :djs_attending, :text
  end
end
