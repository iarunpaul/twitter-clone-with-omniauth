module Api
  module V1
    class TweeetsController < ApplicationController
      # http_basic_authenticate_with name: "admin", password: "secret"
      before_action :restrict_api
      respond_to :json


      class Tweeet < ::Tweeet
        def as_json(options = {})
          super.merge(version: 'v1')
        end
      end

      def index
        @tweeets = Tweeet.includes(:user)
        respond_with @tweeets
      end

      def show
        @tweeet = Tweeet.find(params[:id])
        respond_with @tweeet
      end




    end
  end
end