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
      self.update_attribute :finished_at, DateTime.now
    end
  end
end
