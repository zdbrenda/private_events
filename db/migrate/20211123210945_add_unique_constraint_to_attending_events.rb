class AddUniqueConstraintToAttendingEvents < ActiveRecord::Migration[6.1]
  def change
    add_index :attending_events,[:event_id, :user_id], unique: true
  end
end
