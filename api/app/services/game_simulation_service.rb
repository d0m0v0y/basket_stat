class GameSimulationService
  GAME_DURATION = 2400.seconds
  attr_reader :home_team, :away_team, :ball_possession,
              :time_to_play, :game

  def initialize(game)
    @game = game
    @home_team = game.home_team
    @away_team = game.away_team
    @time_to_play = GAME_DURATION
  end

  def simulate
    game.start

    first_possession

    while time_to_play > 0
      # Rails.logger.info("time_to_play: #{time_to_play}")
      possession_time = get_possession_time

      if try(:turn_over)
        fix_event(:stl, defence_team.players.sample)
        fix_event(:los, offence_team.players.sample)
        end_attack possession_time
        next
      end

      # do attack with probability 95%
      if try(:shot)
        shot_points = [2,3].sample
        if shot_success?(shot_points)
          event = shot_points == 2 ? :fgm : :fgm3
          shot_player = offence_team.players.sample
          fix_event(event, shot_player)
          fix_event(:ast, assist_player(shot_player)) if try(:assist)
          end_attack(possession_time)
          next
        end

        if try(:blockshot)
          fix_event(:blk, defence_team.players.sample)
          end_attack(possession_time)
          next
        end

        if try(:foul)
          player = fix_foul
          points_on_foul = 0
          shot_points.times do
            if try(:free_shot)
              points_on_foul +=1
              fix_event(:ftm, player)
            else
              fix_event(:fta, player)
            end
          end

          if shot_points == points_on_foul
            end_attack(possession_time)
            next
          end
        end
      end

      if try(:offensive_rebound)
        fix_event(:orb, offence_team.players.sample)
        fix_played_time(possession_time)
        next
      else
        fix_event(:drb, defence_team.players.sample)
      end

      end_attack(possession_time)
    end
    game.finish
    Rails.logger.info "GAME SCORES ---- | home: #{game.home_team_scores} | away: #{game.away_team_scores} "
  end

  def end_attack(possession_time)
    fix_played_time(possession_time)
    change_ball_possession
  end

  def fix_event(event, player)
    Rails.logger.info("GAME EVENT: #{event} for #{player.full_name} ##{player.number} from team: #{player.team.name}")
    GameEvent.create(game: game, player: player, event_code: event, event_time: Time.current)
  end

  def shot_success?(shot_points)
    shot_points == 2 ? probability(rand(60..70)) : probability(rand(20..40))
  end

  def fix_foul
    fix_event(:pf, defence_team.players.sample)
    foul_player = offence_team.players.sample
    fix_event(:pfc, foul_player)
    foul_player
  end

  def assist_player(shot_player)
    offence_team.players.shuffle.detect { |p| p != shot_player}
  end

  def first_possession
    @ball_possession = [home_team, away_team].sample
  end

  def get_possession_time(full_attack = true)
    max_attack_time = full_attack ? 24 : 14
    time_to_attack = (time_to_play > max_attack_time) ? max_attack_time : time_to_play
    rand(1..time_to_attack).seconds
  end

  def change_ball_possession
    @ball_possession = defence_team
  end

  def try(action)
    case action
    when :turn_over
      probability(5)
    when :blockshot
      probability(5)
    when :shot
      probability(95)
    when :foul
      probability(20)
    when :free_shot
      probability(rand(60..90))
    when :assist
      probability(rand(30..40))
    end
  end

  def probability(percentage)
    rand(0..100) <= percentage
  end

  def fix_played_time(time)
    @time_to_play -= time
  end

  def offence_team
    @ball_possession
  end

  def defence_team
    [home_team, away_team].detect {|a| a != ball_possession}
  end

end