module Api
  module V1
    class SeasonTeamsController < ApiController
      before_action :prepare_season
      before_action :check_season, only: [:add_teams, :remove_teams]

      def index
        @teams = @season.teams
        puts "teams: #{@teams.inspect}"
        render json: @teams
      end

      def add_teams
        @teams = Team.where(id: team_ids)
        @season.teams << @teams
        render json: @season
      end

      def remove_teams
        @season_teams = @season.season_teams.where(team_id: team_ids).destroy_all
        render json: @season
      end

      def schedule

      end

      private
      def prepare_season
        champ = Championship.find(params.require(:championship_id))
        @season = champ.seasons.find(params.require(:season_id))
      end

      def check_season
        if @season.scheduled?
          @season.errors.add(:season, "Season is already scheduled and teams are locked.")
          render json: @season.errors, status: :conflict
        end
      end

      def team_ids
        params.require(:teams).require(:id)
      end
    end
  end
end
