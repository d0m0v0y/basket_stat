module Api
  module V1
    class PlayerTimesController < ApiController

      api :GET, '/player_times/:id', 'Show player time'
      param :id, :number, :required => true
      def show
        @player_time = PlayerTime.find(params[:id])
        respond_with @player_time
      end

      api :POST, '/player_times', 'Create "player in game" event'
      param :player_time, Hash do
        param :game_id, :number, :desc => 'ID of the current game'
        param :player_id, :number, :desc => 'ID of current player'
        param :in_time, String, :desc => 'Time when player come IN game'
        # param :out_time, String, :required => false, :desc => 'Time of game when player get out'
      end
      def create
        @player_time = PlayerTime.new(player_time_params)
        if @player_time.save
          respond_with @player_time, status: :created
        else
          render json: @player_time.errors, status: :unprocessable_entity
        end
      end

      api :PATCH, '/player_times', "Update player time entry and set 'game out' time"
      param :player_time, Hash do
        param :game_id, :number, :desc => 'ID of the current game'
        param :player_id, :number, :desc => 'ID of current player'
        param :out_time, String, :desc => 'Time of game when player get out'
      end
      def update
        @player_time = PlayerTime.to_update(player_time_params[:game_id], player_time_params[:player_id]).first
        if @player_time.update_attributes(player_time_params)
          # head :no_content
          respond_with @player_time, status: :accepted
        else
          render json: @player_time.errors, status: :unprocessable_entity
        end
      end

      private

      def player_time_params
        params.require(:player_time).permit(:game_id, :player_id, :in_time, :out_time)
      end

    end
  end
end
