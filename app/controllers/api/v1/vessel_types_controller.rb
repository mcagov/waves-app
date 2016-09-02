module Api
  module V1
    class VesselTypesController < ApiController
      def index
        @vessel_types = VesselType.all.order(:name)
        render json: @vessel_types
      end
    end
  end
end
