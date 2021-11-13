# https://stackoverflow.com/questions/4116067/purge-or-recreate-a-ruby-on-rails-database

# first, reset the database
# db:reset

# second, reload the the current schema
# db:migrate


# third, rescrape the website
# require 'rest-client'
# response = RestClient.get ‘https://content.osu.edu/v2/classes/search?q=cse&campus=col&p=1&term=1222&subject=cse&academic-career=ugrd’
# put response.body

#--------------------------------------------------------------------------------------
require 'rest-client'
require 'json'
# this line was aided by https://stackoverflow.com/questions/7702980/rack-error-loaderror-cannot-load-such-file/7710022
require File.dirname(__FILE__) + '/scrapeData.rb'
#require '~/GitHub_Repo/CASH-D/lab-3/app/controllers/application_controller.rb'
#require '~/GitHub_Repo/CASH-D/lab-3/app/controllers/courses_controller.rb'

def main
  #@courses = Course.all
  #clear_courses
  #update_course_data
  app.get '/courses'
  response = app.response
  puts response.body
end
