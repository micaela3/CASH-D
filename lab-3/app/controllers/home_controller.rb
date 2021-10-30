class HomeController < ApplicationController
  def index
    @courses = Course.where(nil);
    @courses = @courses.filter_by_starts_with(params[:starts_with]) if params[:starts_with].present?
  end
end
