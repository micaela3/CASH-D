class GraderApplicationController < ApplicationController

  def get

      # If the current user has filled out a form, get their information, if not create a new grader object.
      if current_user.has_grader
        @grader = Grader.find_by user:current_user
        @currAvails = Availability.where(grader:@grader)
        @courseInts = CoursesGrader.where(grader:@grader)
      else 
        @grader = Grader.new
      end

      @courses = Course.all
      @graders = Grader.all
      @availabilities = Availability.all
      @courses_graders = CoursesGrader.all

      @terms = []
      
      # Get date, month, and next year for calculating terms
      today = Date.today
      month = today.month
      next_year = today + 1.year

      # Get current and next terms 
      if month < 5
          @terms = [
            [today.strftime("Spring %Y"), today.strftime("1%y2")],
            [today.strftime("Summer %Y"), today.strftime("1%y4")]]
      elsif month < 8
        @terms = [
          [today.strftime("Summer %Y"), today.strftime("1%y4")],
          [today.strftime("Autumn %Y"), today.strftime("1%y8")]]
      else
        @terms = [
          [today.strftime("Autumn %Y"), today.strftime("1%y8")],
          [next_year.strftime("Spring %Y"), next_year.strftime("1%y2")]]
      end     
    
  end

  def post


    @grader = Grader.new
    @grader.name = params[:grader][:name]
    @grader.email = params[:grader][:email]
    @grader.major = params[:grader][:major]
    @grader.name_dot_number = params[:grader][:name_dot_number]
    @grader.semester = params[:grader][:semester]
    @grader.user = current_user    

    @availabilities = params[:availability]
    @course_interests = params[:courses]

    # If grader is editing current form, save their new information and delete old availabilites and course interests.
    if current_user.has_grader
        @currGrader = Grader.find_by user:current_user
        Availability.where(grader:@currGrader).delete_all
        CoursesGrader.where(grader:@currGrader).delete_all   

        @currGrader.name = @grader.name
        @currGrader.email = @grader.email
        @currGrader.major = @grader.major
        @currGrader.name_dot_number = @grader.name_dot_number
        @currGrader.semester = @grader.semester

        @currGrader.save 

        @availabilities.each do |index, value|
            @availability = Availability.new  
            @availability.weekday = @availabilities[index][:weekday]
            @availability.start_time = @availabilities[index][:start_time]
            @availability.end_time = @availabilities[index][:end_time]
            @availability.grader = @currGrader  
            @availability.save
        end      
     
        @course_interests.each do |index, value|
            @courses_graders = CoursesGrader.new          
            @courses_graders.course_id = @course_interests[index][:course_id]
            @courses_graders.grader = @currGrader          
            @courses_graders.save
        end
     
    # If grader is filling out form for first time save their information, availabilites, and course interests.
    else 
        @grader.save     

        @availabilities.each do |index, value|
            @availability = Availability.new  
            @availability.weekday = @availabilities[index][:weekday]
            @availability.start_time = @availabilities[index][:start_time]
            @availability.end_time = @availabilities[index][:end_time]
            @availability.grader = @grader  
            @availability.save
        end     
      
        @course_interests.each do |index, value|
              @courses_graders = CoursesGrader.new          
              @courses_graders.course_id = @course_interests[index][:course_id]
              @courses_graders.grader = @grader          
              @courses_graders.save
        end
        
        current_user.has_grader = true
        current_user.save            
    
    end 

    # Notify user of successful form submission.
    redirect_to root_path, notice: "Form submission successful!"   

  end


  # Deletes grader form and all objects created from grader form.
  def deleteForm
    if current_user.has_grader
        @currGrader = Grader.find_by user:current_user      
        Availability.where(grader:@currGrader).delete_all
        CoursesGrader.where(grader:@currGrader).delete_all 
        @currGrader.destroy
        current_user.has_grader = false
        current_user.save
        # Notify user of succesful form deletion.
        redirect_to root_path, notice: "Form deletion successful!"  
    end
  end

end
