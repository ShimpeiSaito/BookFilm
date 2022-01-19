class MoviesController < ApplicationController
  # 作品一覧
  def index
      @movies = Movie.where("released_at < ? and expired_at > ?", Date.today, Date.today).order(:title)
          .page(params[:page]).per(15)
  end

  # 作品検索
  def search
      @movies = Movie.where("released_at < ? and expired_at > ?", Date.today, Date.today).search(params[:q], params[:m], params[:w])
          .page(params[:page]).per(15)
      render "index"
  end

  # 作品の詳細
  def show
      @movie = Movie.find(params[:id])
      @schedules = @movie.schedules
      @thea_id = []
      for schedule in @schedules do
        @thea_id.push(schedule.thea)
      end
      @theaters = Theater.where(id: @thea_id).order(:store_name)
          .page(params[:page]).per(5)
  end
end
