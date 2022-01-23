class TheatersController < ApplicationController
  before_action :admin_logout

  def index
    @theaters = Theater.order(:store_name)
        .page(params[:page]).per(5)
  end

  def show
    @theater = Theater.find(params[:id])
    @schedules = @theater.schedules
    @mov_id = []
    for schedule in @schedules do
      @mov_id.push(schedule.mov)
    end
    @movies = Movie.where(id: @mov_id).where("released_at < ? and expired_at > ?", Date.today, Date.today).where("release_flag = ?", 1).order(:title)
        .page(params[:page]).per(15)
  end
end
