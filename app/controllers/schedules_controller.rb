class SchedulesController < ApplicationController
  before_action :admin_logout

  def show
    @movie = Movie.find(params[:id])
    @theater = Theater.find(params[:theater_id])
    @schedules = Schedule.where("(theater_id = ?) and (movie_id = ?) and (screening_date >= ?)", @theater.id, @movie.id, Date.today).where("endtime >= ?", Time.now).order(:screening_date).order(:starttime)
        .page(params[:page]).per(10)
  end
  
  def byday
    @movie = Movie.find(params[:movid])
    @theater = Theater.find(params[:theater_id])
    date = Date.new(Time.zone.now.year, Time.zone.now.month ,Time.zone.now.day + (params[:day]).to_i)
    @schedules = Schedule.where("(theater_id = ?) and (movie_id = ?)", @theater.id, @movie.id).where(screening_date: date).where("endtime >= ?", Time.now).order(:screening_date).order(:starttime)
        .page(params[:page]).per(10)
    render "show"
  end
end
