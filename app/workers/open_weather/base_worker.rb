require 'faraday'

module OpenWeather
  class BaseWorker
    include Sidekiq::Worker

    def perform(user_id = nil)
      @user = User.find_by(id: user_id)
      if @user.nil?
        Rails.logger.warn "#{self.class.name} :: No user found with ID: #{user_id}. Exiting worker."
        return
      end
    
      @cities = @user.cities
      if @cities.empty?
        Rails.logger.warn "#{self.class.name} :: No cities found for user: #{@user.id}. Exiting worker."
        return
      end
    
      @cities.find_each(batch_size: 25) do |city|
        body = options(city)
        begin
          get_city_weather(body)
          process_data(city)
        rescue => e
          Rails.logger.error "#{self.class.name} :: Error processing city #{city.id}: #{e.message}"
        end
      end
    
      Rails.logger.info "#{self.class.name} :: Worker completed for City IDs: #{@cities.map(&:id).join(', ')}"
    end

    protected
    def url
      raise "Unimplemented: #{self.class.name}#url #{inspect}"
    end

    def options
      raise "Unimplemented: #{self.class.name}#options #{inspect}"
    end

    private
    def get_city_weather(body)
      response = Faraday.get(url, body)

      if response.success?
        @data = JSON.parse(response.body)
      else
        Rails.logger.error "#{self.class.name} :: Failed to fetch weather data :: #{response.status} #{response.reason_phrase}"
        raise "#{self.class.name} :: City id: #{@city.id} :: Failed to fetch weather data: #{response.status} #{response.reason_phrase}"
      end
    end
  end
end