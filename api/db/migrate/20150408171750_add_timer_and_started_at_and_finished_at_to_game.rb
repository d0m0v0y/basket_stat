class AddTimerAndStartedAtAndFinishedAtToGame < ActiveRecord::Migration
  def change
    add_column :games, :timer, :integer
    add_column :games, :started_at, :datetime
    add_column :games, :finished_at, :datetime
  end
end
