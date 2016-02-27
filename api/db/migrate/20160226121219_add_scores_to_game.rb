class AddScoresToGame < ActiveRecord::Migration
  def change
    add_column :games, :home_team_scores, :integer
    add_column :games, :away_team_scores, :integer
  end
end
