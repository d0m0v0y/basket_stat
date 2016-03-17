class LineupSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :team_id, :player_id
end
