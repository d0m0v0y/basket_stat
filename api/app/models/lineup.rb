class Lineup < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :player

  scope :by_team, ->(team) { where(team: team) }
end