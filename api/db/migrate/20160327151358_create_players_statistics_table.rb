class CreatePlayersStatisticsTable < ActiveRecord::Migration
  def change
    create_table :players_statistics do |t|
      t.belongs_to :player, index: true
      t.belongs_to :statistic, index: true
    end
  end
end
