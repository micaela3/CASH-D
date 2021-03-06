class MeetingsController < ApplicationController
  # Calls this function before the webpage loads
  before_action :authenticate
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @section = params[:prev_section_id]
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @section = params[:prev_section_id]
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity, params: {prev_section_id: @section} }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @section = @meeting.section
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to @section, notice: "Meeting was successfully destroyed." }
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
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:start_time, :end_time, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :location, :section_id)
    end
end
