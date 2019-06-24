class WeatherService
  def get_weather(city)
    fail ArgumentError.new('city cannot be nil') if city.nil?

    weather = Openweather2.get_weather(city: city, units: 'imperial')
  end
end
