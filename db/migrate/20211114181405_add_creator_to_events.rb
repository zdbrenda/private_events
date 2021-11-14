class AddCreatorToEvents < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :creator, null: false
    add_foreign_key :events, :users, column: :creator_id
  end
end
