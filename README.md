# README

# Weather Tracker Application

This project is a weather tracking application that allows you to monitor weather conditions for various cities.

Requirements:
- Ruby Version: 3.2.0
- Database: PostgreSQL (recommended)
- Redis Server: Ensure Redis is installed and running.

Setup Instructions:

Follow these steps to get the project up and running:

1. Clone the Repository:
   git clone <repository-url>
   cd <repository-directory>

2. Install Dependencies:
   bundle install

3. Configure the Database:
   Add your database username and password to the `.env` file:
   DATABASE_USERNAME=<your-database-username>
   DATABASE_PASSWORD=<your-database-password>

4. Set Up the Database:
   rails db:setup

5. Ensure Redis Server is Running:
   Start your Redis server if it's not already running.

6. Obtain an OpenWeatherMap API Key:
   Go to https://openweathermap.org/, create an account, and get your API key.
   Add the API key to your `.env` file:
   OPEN_WEATHER_KEY=<your-api-key>

7. To populate the database with default data
   rails db:seed

8. To populate the database with default cities just use the rake task
   bundle exec rake db:import_cities

9. Configure Cron Jobs:
   Ensure your system supports Cron for scheduling tasks.
   The app requires a Cron job to fetch temperatures for cities every day at 12:00 PM. To set this up, run:
   bundle exec whenever --update-crontab
   Read schedule.rb comments for more info

10. Start the Server:
   bin/dev
