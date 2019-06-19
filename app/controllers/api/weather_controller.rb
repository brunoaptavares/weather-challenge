module Api
  class WeatherController < ApplicationController
    helper WeatherHelper

    respond_to :json

    def forecast
      params.require(:city)

      @weather = Openweather2.get_weather(city: params[:city], units: 'imperial')
      respond_with(@weather)
    rescue => e
      render json: { error: e, message: 'erro ao buscar a previsao' }, status: 500
    end
  end
end
