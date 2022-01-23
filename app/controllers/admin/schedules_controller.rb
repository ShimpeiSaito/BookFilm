class Admin::SchedulesController < Admin::Base
  before_action :admin_login_required
  
  def index
    @schedules = Schedule.all.order(starttime: :desc).order(theater_id: :asc)
        .page(params[:page]).per(15)
  end
  
  def new
    @schedule = Schedule.new()
    @theaters = Theater.all()
    @movies = Movie.where("expired_at >= ?", Date.today).where("release_flag = ?", 1)
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.thea = Theater.find(params[:schedule][:thea])
    @schedule.mov = Movie.find(params[:schedule][:mov])
    @schedule.starttime = Time.new(@schedule.screening_date.year, @schedule.screening_date.month, @schedule.screening_date.day, @schedule.starttime.hour, @schedule.starttime.min, @schedule.starttime.sec, '+09:00')
    @schedule.endtime = @schedule.starttime + (@schedule.mov.screening_time * 60)

    if @schedule.save
      redirect_to admin_schedules_path, notice: "上映を追加しました。"
    else
      @theaters = Theater.all()
      @movies = Movie.where("expired_at >= ?", Date.today).where("release_flag = ?", 1)
      render "new"
    end
  end

  private def schedule_params
    params.require(:schedule).permit(
      :screen_no,
      :screening_date,
      :starttime
    )
  end
end
