# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

#1.- correr redis-server
#2.- correr bundle exec sidekiq
#3.- whenever --update-crontab
#4._ crontab -l

#  whenever --update-crontab
#  crontab -l

set :output, {:error => 'log/cron.log', :standard => 'log/standard.log'}

 every 5.minute do
  puts 'runner new tracking job'
  runner "NewTrackingJob.perform_later"
 end
 
#
 every 10.days do
   runner "StatusTrackingJob.perform_later"
 end

# Learn more: http://github.com/javan/whenever
