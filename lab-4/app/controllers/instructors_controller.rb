class InstructorsController < ApplicationController
  # Calls this function before the webpage loads
  before_action :authenticate
  before_action :set_instructor, only: %i[ show edit update destroy ]

  # GET /instructors/1 or /instructors/1.json
  def show
  end

  # GET /instructors/new
  def new
    @meeting = params[:prev_meeting_id]
    @instructor = Instructor.new
  end

  # GET /instructors/1/edit
  def edit
  end

  # POST /instructors or /instructors.json
  def create
    @meeting = params[:prev_meeting_id]
    @instructor = Instructor.new(instructor_params)

    respond_to do |format|
      if @instructor.save
        format.html { redirect_to @instructor, notice: "Instructor was successfully created." }
        format.json { render :show, status: :created, location: @instructor }
      else
        format.html { render :new, status: :unprocessable_entity, params: {prev_meeting_id: @meeting} }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1 or /instructors/1.json
  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to @instructor, notice: "Instructor was successfully updated." }
        format.json { render :show, status: :ok, location: @instructor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1 or /instructors/1.json
  def destroy
    @meeting = @instructor.meeting
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to @meeting, notice: "Instructor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    #Authenticate if the user is signed in
    def authenticate
      #Do unless the user is signed in
      unless user_signed_in?
        # Redirect the user to the root page to sign/up or sign in and Flash a alert to the user when they try to access the page without signing in 
        redirect_to root_path, notice: "Login before trying to access this page"
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instructor_params
      params.require(:instructor).permit(:instructor_name, :instructor_email, :meeting_id)
    end
end
