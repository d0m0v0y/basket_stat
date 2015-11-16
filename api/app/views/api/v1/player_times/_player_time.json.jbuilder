json.(player_time, :id, :game_id, :player_id)
json.in_time player_time.in_time.to_s(:timespan) if player_time.in_time.present?
json.out_time player_time.out_time.to_s(:timespan) if player_time.out_time.present?