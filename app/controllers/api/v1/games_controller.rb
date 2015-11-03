module Api
  module V1
    class GamesController < ApiController

      api :GET, '/games', 'Show list of games'
      formats [:json]
      def index
        @games = Game.all
        render json: @games
      end

      api :GET, '/games/:id', 'Show game by id'
      formats [:json]
      param :id, :number, required: true
      def show
        @game = Game.find(params[:id])
        render json: @game
      end

      api :POST, '/games', 'Create game'
      formats [:json]
      param :game, Hash do
        param :date, String, desc: 'Date of the game in format YYYY-MM-DD'
        param :home_team_id, :number, desc: 'ID of the Home team'
        param :away_team_id, :number, desc: 'ID of the Away team'
      end
      def create
        @game = Game.new(game_params)
        if @game.save
          render json: @game, status: :created
        else
          render json: @game.errors, status: :unprocessable_entity
        end
      end

      api :post, '/games/:game_id/start', 'Set started_at in current game '
      formats [:json]
      param :game_id, :number, required: true
      def start
        @game = Game.find(params[:game_id])
        @game.start
        render json: @game
      end

      api :post, '/games/:game_id/finish', 'Set started_at in current game '
      formats [:json]
      param :game_id, :number, required: true
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
