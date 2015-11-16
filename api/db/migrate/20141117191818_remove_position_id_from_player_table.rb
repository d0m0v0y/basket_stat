class RemovePositionIdFromPlayerTable < ActiveRecord::Migration
  def change
    remove_column :players, :position_id
  end
end

