class MoviesController < ApplicationController
  # 会員一覧
  def index
      @movies = Movie.order(:title)
          .page(params[:page]).per(15)
  end

  # 検索
  def search
      @movies = Movie.search(params[:q], params[:m], params[:w])
          .page(params[:page]).per(15)
      render "index"
  end

  # 会員情報の詳細
  def show
      @movie = Movie.find(params[:id])
  end
end
