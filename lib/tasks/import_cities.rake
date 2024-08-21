namespace :db do
  desc "Import cities from cities.yml file into the database"
  task import_cities: :environment do
    cities_data = YAML.load_file(File.join(Rails.root, "lib", "tasks", "data", 'cities.yml'))
    exit unless cities_data

    user = User.find_by(email: "testuser@example.com")
    if user.nil?
      puts "No default user found"
      exit
    end

    cities_data['cities'].each do |city|
      City.find_or_create_by!(name: city['name'], lat: city['lat'], lon: city['lon'], user_id: user.id)
    end

    puts "Created #{cities_data.size} cities into the database."
  end
end
