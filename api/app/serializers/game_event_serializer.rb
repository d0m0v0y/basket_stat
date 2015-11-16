class GameEventSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :player_id, :event_code, :event_time

  def event_time
    object.event_time.to_s(:timespan)
  end
end
