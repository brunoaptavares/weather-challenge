object @weather
attribute :city
attribute :longitude
attribute :latitude
attribute :temperature
attribute :pressure
attribute :humidity
attribute :min_temperature
attribute :max_temperature
attribute :clouds
attribute :wind_speed
attribute :wind_angle
node(:celsius_temperature) { fahrenheit_to_celsius(@weather.temperature) }
