class RecommendationsController < ApplicationController
 
 def get
   @courses = Course.all
   @graders = Grader.all
   @instructors = Instructor.all 
 end 
  def new
    @recommendation = Recommendation.new 
    @recommendation.instructor_name = params[:recommendation][:instructor_name]
    @recommendation.grader_name = params[:recommendation][:grader_name]
    @recommendation.user = current_user
    @recommendation.grader_name_dot_number = params[:recommendation][:grader_name_dot_number]
    @recommendation.course = params[:recommendation][:course]
    if params[:recommendation][:section] == ""
        @recommendation.section = -1
        puts "blashs"
    else
        puts "badksbhdjksa"
        @recommendation.section = params[:recommendation][:section]
    end
    @recommendation.comments = params[:recommendation][:comments]
    
  if @recommendation.save
    redirect_to root_path
  else
    puts "error"
  end
  end

end


