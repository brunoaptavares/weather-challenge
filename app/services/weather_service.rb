class WeatherService
  def get_weather(city)
    weather = Openweather2.get_weather(city: city, units: 'imperial')
  end
end
