class GameSerializer < ActiveModel::Serializer
  attributes :id, :away_team_id, :home_team_id, :date,
             :started_at, :finished_at

  has_one :home_team, embed: :ids, key: :home_team_id, root: :teams
  has_one :away_team, embed: :ids, key: :away_team_id, root: :teams
  has_many :statistics
end
