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
    @recommendation.course_number = params[:recommendation][:course_number]
    if params[:recommendation][:section] == ""
        @recommendation.section = -1
    else
        @recommendation.section = params[:recommendation][:section]
    end
    @recommendation.comments = params[:recommendation][:comments]
  if @recommendation.save
    redirect_to root_path, notice: "Form submission successful!"
  end
  end

end


