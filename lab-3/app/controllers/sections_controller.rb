class SectionsController < ApplicationController
  # Calls this method before the webpage loads
  before_action :authenticate
  before_action :set_section, only: %i[ show edit update destroy ]

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections or /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    @course = @section.course
    @section.destroy
    respond_to do |format|
      format.html { redirect_to @course, notice: "Section was successfully destroyed." }
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
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.require(:section).permit(:section_number, :class_number, :component, :start_date, :end_date, :course_id)
    end
end
