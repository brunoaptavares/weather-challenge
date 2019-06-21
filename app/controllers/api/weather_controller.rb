module Api
  class WeatherController < ApplicationController
    helper WeatherHelper

    respond_to :json

    def forecast
      params.require(:city)

      @weather = weather_service.get_weather(params[:city])
      respond_with(@weather)
    rescue => e
      render json: { error: e, message: 'erro ao buscar a previsao' }, status: 500
    end

    private

    def weather_service
      @weather_service ||= WeatherService.new
    end
  end
end
