module Api
  module V1
    class CountriesController < ApiController
      def index
        @countries = Country.all
        render json: @countries
      end
    end
  end
end
