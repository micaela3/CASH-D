class GraderApplicationController < ApplicationController
  def getNew
    @courses = Course.all
  end
  def postNew
    grader = Grader.new
    grader.name = params[:grader][:name]
    grader.email = params[:grader][:email]
    
    grader.save    
    
    availabilities = params[:availability]

    availabilities.each do |index, value|
      availability = Availability.new

      puts availabilities[index][:weekday]
      puts availabilities[index][:start_time]
      puts availabilities[index][:end_time]
    end
     
    puts grader.name
    puts grader.user_id
  end

  def edit
  end
end
