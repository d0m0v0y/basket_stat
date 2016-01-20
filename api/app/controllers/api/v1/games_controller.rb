module Api
  module V1
    class GamesController < ApiController

      def index
        @games = Game.all
        render json: @games
      end

      def show
        @game = Game.find(params[:id])
        render json: @game
      end

      def create
        @game = Game.new(game_params)
        if @game.save
          render json: @game, status: :created
        else
          render json: @game.errors, status: :unprocessable_entity
        end
      end

      def start
        @game = Game.find(params[:game_id])
        @game.start
        render json: @game
      end

      def finish
        @game = Game.find(params[:game_id])
        @game.finish

        render json: @game
      end

      private

      def game_params
        params.require(:game).permit(:date, :home_team_id, :away_team_id)
      end
    end
  end
end
