namespace :schedule do
  
  desc "Sync temperature of all cities"
  task sync_cities_temperature: :environment do
    User.find_each(batch_size: 50) do |user|
      OpenWeather::BasicCityWeatherWorker.perform_async(user.id)
    end
  end

end