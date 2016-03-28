class RemovePlayerIdFromStatisticsTable < ActiveRecord::Migration
  def change
    remove_column :statistics, :player_id, :integer
  end
end
