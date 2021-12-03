class GraderApplicationController < ApplicationController
  def get
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
    # Get current and next terms (commented out code for 2-our terms)
    if month < 5
        @terms = [
          [today.strftime("Spring %Y"), today.strftime("1%y2")],
          [today.strftime("Summer %Y"), today.strftime("1%y4")],
#          [today.strftime("Autumn %Y"), today.strftime("1%y8")]
        ]
    elsif month < 8
      @terms = [
        [today.strftime("Summer %Y"), today.strftime("1%y4")],
        [today.strftime("Autumn %Y"), today.strftime("1%y8")],
#        [next_year.strftime("Spring %Y"), next_year.strftime("1%y2")]
      ]
    else
      @terms = [
        [today.strftime("Autumn %Y"), today.strftime("1%y8")],
        [next_year.strftime("Spring %Y"), next_year.strftime("1%y2")],
#        [next_year.strftime("Summer %Y"), next_year.strftime("1%y4")]
      ]

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

    redirect_to root_path, notice: "Form submission successful!"   

  end



  def deleteForm
    if current_user.has_grader
      @currGrader = Grader.find_by user:current_user      
      Availability.where(grader:@currGrader).delete_all
      CoursesGrader.where(grader:@currGrader).delete_all 
      @currGrader.destroy
      current_user.has_grader = false
      current_user.save

      redirect_to root_path, notice: "Form deletion successful!"  
    end

  end

end
