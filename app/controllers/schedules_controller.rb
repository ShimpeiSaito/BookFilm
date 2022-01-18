class SchedulesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @theater = Theater.find(params[:theater_id])
    @schedules = Schedule.where("(theater_id = ?) and (movie_id = ?)", @theater.id, @movie.id).order(:screening_date).order(:starttime)
        .page(params[:page]).per(10)
  end
  
  def byday
    @movie = Movie.find(params[:movid])
    @theater = Theater.find(params[:theater_id])
    @schedules = Schedule.where("(theater_id = ?) and (movie_id = ?)", @theater.id, @movie.id).where(screening_date: Date.today.days_since((params[:day]).to_i)).order(:screening_date).order(:starttime)
        .page(params[:page]).per(10)
    render "show"
  end
end
