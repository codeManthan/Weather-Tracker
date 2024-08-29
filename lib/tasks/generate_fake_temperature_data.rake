namespace :db do
  desc "Generate fake temperature data for a range of dates"
  task :generate_fake_temperature_data, [:start_date, :end_date, :email] => :environment do |_, args|
    start_date = args[:start_date].to_date
    end_date = args[:end_date].to_date
    email = args[:email]

    if start_date.nil? || end_date.nil?
      puts "Please provide a valid start date and end date in the format: rake db:generate_fake_temperature_data[start_date,end_date,email]"
      exit
    end

    # Determine the cities based on the presence of the email argument
    cities = email.nil? ? City.all : User.find_by(email: email)&.cities

    if cities.nil? || cities.empty?
      puts "No cities found for the given email: #{email}" if email
      exit
    end

    # Iterate over the range of dates
    (start_date..end_date).each do |date|
      cities.find_each do |city|
        # Create fake temperature data for each city
        city.temperatures.create!(
          temperature: rand(290.15..310.15), # Random temperature between 290K and 310K
          recorded_at: date.to_time,
          icon: "50d",
          humidity: rand(60.0..80.0),
          wind_speed: rand(1.0..10.0),
          mainline: "Clear",
          description: "clear sky"
        )
      end
      puts "Generated data for #{date}"
    end
  end
end
