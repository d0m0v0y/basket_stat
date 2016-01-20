module Api
  module V1
    class PlayersController < ApiController

      def index
        @players = Player.all
        @players = @players.where(team_id: params.permit(:team_id)) if params[:team_id].present?
        render json: @players
      end

      def show
        id = params.require :id
        @player = Player.where(id: id)

        if @player.present?
          render json: @player, status: :ok
        else
          render json: @player, status: :not_found
        end
      end

      def create
        @player = Player.new(player_params)
        if @player.save
          render json: @player, status: :created
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      def update
        @player = Player.find(params[:id])
        if @player.update_attributes(player_params)
          # head :no_content
          render json: @player, status: :accepted
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @player = Player.find(params[:id])
        @player.destroy
        head :no_content
      end

      private

      def player_params
        params.require(:player).permit(:team_id, :first_name, :last_name,
                                       :birth_date, :height, :weight, :position,
                                       :number)
      end

      def find_player_params
        params.require(:id)
      end

    end
  end
end
