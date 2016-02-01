class Season < ActiveRecord::Base
  belongs_to :championship
  has_many :season_teams
  has_many :teams, through: :season_teams

  def scheduled?
    false
  end

end
