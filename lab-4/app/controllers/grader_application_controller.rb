class GraderApplicationController < ApplicationController
  def get
    @courses = Course.all
    @graders = Grader.all
    @availabilities = Availability.all

    
  end

  def post
    @grader = Grader.new
    @grader.name = params[:grader][:name]
    @grader.email = params[:grader][:email]
    @grader.major = params[:grader][:major]
    @grader.user = current_user
    @grader.save
    
    @availabilities = params[:availability]

    @availabilities.each do |index, value|
      @availability = Availability.new

      @availability.weekday = @availabilities[index][:weekday]
      @availability.start_time = @availabilities[index][:start_time]
      @availability.end_time = @availabilities[index][:end_time]
      @availability.grader = @grader

      @availability.save
    end
     

  end

  def edit
  end
end
