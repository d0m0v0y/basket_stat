class Game < ActiveRecord::Base
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  has_many :statistics

  validates :away_team_id, :home_team_id, :date, presence: true

  def start
    self.update_attribute :started_at, DateTime.now if started_at.blank?
  end

  def finish
    if finished_at.blank?
      # save players stats to db
      home_team.players.each { |player| player.save_stats(id) }
      away_team.players.each { |player| player.save_stats(id) }
      self.update_attributes(
        finished_at: DateTime.now,
        home_team_scores: calculate_scores(home_team),
        away_team_scores: calculate_scores(away_team),
      )
    end
  end

  def scores
    home_team_scores = calculate_scores home_team
    away_team_scores = calculate_scores away_team
    [home_team_scores, away_team_scores]
  end

  def calculate_scores(team)
    team.players.inject(0) { |sum, player| sum + player.points(id) }
  end
end
