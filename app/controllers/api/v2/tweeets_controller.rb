module Api
  module V2
    class TweeetsController < ApplicationController
      # respond_to :json
      def index
        @tweeets = Tweeet.includes(:user)
        render json: @tweeets
      end

      def show
        @tweeet = Tweeet.find(params[:id])
        render json: @tweeet
      end


    end
  end
end