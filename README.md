# Weather Tracker Application

Welcome to the Weather Tracker Application! This project allows you to monitor weather conditions for various cities.

## Requirements

- Ruby Version: 3.2.0 
  Recommended rbenv
- Database: PostgreSQL (recommended)
- Redis Server: Ensure Redis is installed and running.
- Make sure nvm, node and yarn are ready to use

## Setup Instructions

Follow these steps to get the project up and running:

1. **Clone the Repository**
   ```
   git clone repository-url
   cd repository-directory
   ```

2. **Install GEMS**
   ```
   bundle install
   ```

3. **Install Yarn packages**
   ```
   yarn
   ```

4. **Configure the Database**

   Add your database username and password to the `.env` file:
   DATABASE_USERNAME=your-database-username
   DATABASE_PASSWORD=your-database-password

5. **Set Up the Database**
   ```
   rails db:create
   rails db:setup
   ```

6. **Ensure Redis Server is Running**

   Start your Redis server if it's not already running.

7. **Obtain an OpenWeatherMap API Key**

   1. Go to https://openweathermap.org/, create an account, and get your API key.
   2. Add the API key to your `.env` file:

   ```
   OPEN_WEATHER_KEY=<your-api-key>
   ```

8. **Populate the Database with Default user**

   ```
   rails db:seed
   ```


9. **Import Default Cities**

   Use the rake task to import default cities:
   ```
   bundle exec rake db:import_cities
   ```

10. **Configure Cron Jobs**

   Ensure your system supports Cron for scheduling tasks. The app requires a Cron job to fetch temperatures for cities every day at 12:00 PM. To set this up, run:

   ```
   bundle exec whenever --update-crontab
   ```

   Check the `schedule.rb` comments for more details.

11. **Start the Server**

    ```
    bin/dev
    ```

12. **Run Test Cases**

   To run the test cases written in RSpec:

   ```
   bundle exec rspec spec
   ```

 13. **To generate fake temperature data for all cities use:**

   The rake task accepts 3 arguments
      1. start date
      2. end date
      3. email of user ( optional, if not provided default is all users )
   
   make sure the dates are in valid format of YYYY-DD-MM

   ```
   bundle exec rake db:generate_fake_temperature_data[start_date,end_date,email]
   ```

DEMO:
   https://drive.google.com/file/d/1BYTcAooF0AsoIbGqeNWw_nheb1iar7Pa/view?usp=sharing
