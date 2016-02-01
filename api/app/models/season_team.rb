class SeasonTeam < ActiveRecord::Base
  belongs_to :season
  belongs_to :team

  validates :team, uniqueness: { scope: :season}
end
