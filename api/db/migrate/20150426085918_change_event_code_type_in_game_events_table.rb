class ChangeEventCodeTypeInGameEventsTable < ActiveRecord::Migration
  def change
    change_column :game_events, :event_code, :integer
  end
end
