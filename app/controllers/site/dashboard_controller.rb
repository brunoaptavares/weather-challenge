module Site
  class DashboardController < ApplicationController
    helper WeatherHelper

    def index
      @weather = Openweather2.get_weather(city: city_param, units: 'imperial')
    rescue
      @weather
    end

    private

    def city_param
      params[:city] || 'Sao Paulo,BR'
    end
  end
end
