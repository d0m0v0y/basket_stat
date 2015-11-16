class PlayerTimeSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :player_id, :in_time, :out_time
end
