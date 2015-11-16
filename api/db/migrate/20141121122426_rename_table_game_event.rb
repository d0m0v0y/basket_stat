class RenameTableGameEvent < ActiveRecord::Migration
  def change
    rename_table :game_event, :game_events
  end
end
