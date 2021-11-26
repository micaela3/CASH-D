class RecommendationsController < ApplicationController
 
 def get
   @courses = Course.all
   @graders = Grader.all
   @instructors = Instructor.all 
 end 
  def new
    @recommendation = Recommendation.new 
    @recommendation.grader_id = params[:recommendation][:grader_id]
    @recommendation.instructor_id = params[:recommendation][:instructor_id]
    @recommendation.course = params[:recommendation][:course]
    @recommendation.section = params[:recommendation][:section]
    @recommendation.comments = params[:recommendation][:comments] 
    @recommendation.grader_name = params[:recommendation][:grader_name]
    @recommendation.instructor_name = params[:recommendation][:instructor_name]
    @recommendation.comments = params[:recommendation][:comments]
    
    @recommendation.save
  end
end


