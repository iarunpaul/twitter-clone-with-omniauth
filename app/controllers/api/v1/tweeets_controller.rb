module Api
  module V1
    class TweeetsController < ApplicationController
      # respond_to :json
      class Tweeet < ::Tweeet
        def as_json(options = {})
          super.merge(version: 'v1')
        end

      end
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