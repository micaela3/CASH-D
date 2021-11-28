class GraderApplicationController < ApplicationController
  def get
    if current_user.has_grader
      @grader = Grader.find_by user:current_user
      @currAvails = Availability.where(grader:@grader)
      @courseInts = CoursesGrader.where(grader:@grader)
    else 


    end

    @courses = Course.all
    @graders = Grader.all
    @availabilities = Availability.all
    @courses_graders = CoursesGrader.all
    
  end

  def post

    if current_user.has_grader
      
    else 
      @grader = Grader.new
      @grader.name = params[:name]
      @grader.email = params[:email]
      @grader.major = params[:major]
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
      
      @course_interests = params[:courses]
      @course_interests.each do |index, value|
          @courses_graders = CoursesGrader.new
          
          @courses_graders.course_id = @course_interests[index][:course_id]
          @courses_graders.grader = @grader
          
          @courses_graders.save
      end
      
      current_user.has_grader = true
      current_user.save
      end    
  end

end
