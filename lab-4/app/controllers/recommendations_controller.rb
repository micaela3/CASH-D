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
    if params[:recommendation][:class_number] == ""
        @recommendation.class_number = -1
    else
        @recommendation.class_number = params[:recommendation][:class_number]
    end
    @recommendation.comments = params[:recommendation][:comments]
  if @recommendation.save
    redirect_to root_path, notice: "Form submission successful!"
  end
  
  end

  def edit
    @recommendation = Recommendation.find(params[:recommendation_id])
  end

  def display
    @recommendations = Recommendation.where(user_id: current_user.id)
    unless @recommendations.count != 0
      redirect_to home_index_path, notice: "No Recommendation filled out yet!"
    end
  end

  # PATCH/PUT /recommendations/1
  def update
    @recommendation = Recommendation.find(params[:recommendation_id])
    respond_to do |format|
      if @recommendation.update(recommendation_params)
        format.html { redirect_to recommendations_display_path, notice: "Recommendation was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendations/1
  def delete
    @recommendation = Recommendation.find(params[:recommendation_id])
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to recommendations_display_path, notice: "Recommendation was successfully destroyed." }
    end
  end
end


