module Api
  module V1
    class GameEventsController < ApiController

      def create
        @event = GameEvent.new(game_event_params)
        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      private

      def game_event_params
        params.require(:game_event).permit(:game_id, :player_id, :event_code, :event_time)
      end

    end
  end
end
