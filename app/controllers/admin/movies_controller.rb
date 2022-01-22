class Admin::MoviesController < Admin::Base
  before_action :admin_login_required

  def index
    @movies = Movie.all.order(released_at: :desc).order(:title)
        .page(params[:page]).per(15)
  end

  def search
    @movies = Movie.all.order(released_at: :desc).search(params[:q])
        .page(params[:page]).per(15)
    render "index"
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new()
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to [:admin, @movie], notice: "作品を追加しました。"
    else
      render "new"
    end
  end

  def destroy
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
  end

  # ストロング・パラメータ
  private def movie_params
    params.require(:movie).permit(
      :title,
      :explanation,
      :released_at,
      :expired_at,
      :screening_time,
      :distribution,
      :director
    )
  end
end
