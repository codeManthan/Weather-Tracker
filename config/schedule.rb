# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# run: bundle exec whenever --update-crontab 
# after adding a new job
# point the correct bundle path in the crontab 

# crontab -l to list the created crons
# crontab -e to edit the created crons

set :output, "log/cron_log.log"  # This sets the log file for the cron job output

every :day, at: '12:00 pm' do
  rake "schedule:sync_cities_temperature"
end
