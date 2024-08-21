module OpenWeather
  class BasicCityWeatherWorker < BaseWorker
    def process_data(city)
      data = filter_data(city)
      Temperature.create!(data)
      Rails.logger.info "#{self.class.name} :: Temperature data saved successfully for City ID: #{city.id}"
    rescue => e
      Rails.logger.error "#{self.class.name} :: Error while processing weather data for City ID: #{city.id}: #{e.message}"
    end

    def url
      url = "https://api.openweathermap.org/data/2.5/weather"
    end

    def options(city)
      {
        lat: city.lat,
        lon: city.lon,
        appid: ENV.fetch("OPEN_WEATHER_KEY")
      }
    end

    def filter_data(city)
      if @data.nil?
        Rails.logger.error "#{self.class.name} :: No data available for City ID: #{city.id}"
        return {}
      end

      {
        temperature: @data.dig('main', 'temp'),
        recorded_at: Time.at(@data.dig('dt')),
        icon: @data.dig('weather', 0, 'icon'),
        humidity: @data.dig('main', 'humidity'),
        wind_speed: @data.dig('wind', 'speed'),
        mainline: @data.dig('weather', 0, 'main'),
        description: @data.dig('weather', 0, 'description'),
        city_id: city.id
      }
    end
  end
end