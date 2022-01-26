class Admin::ReservationsController < Admin::Base
  before_action :admin_login_required

  def index
    @reservations = Reservation.all.order(confirm_time: :desc)
        .page(params[:page]).per(15)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @member = Member.find(@reservation.mem.id)
    @schedule = Schedule.find(@reservation.sche.id)
    @movie = Movie.find(@reservation.sche.mov.id)
    @theater = Theater.find(@reservation.sche.thea.id)
    @adu = Ticket.find(1)
    @mid = Ticket.find(2)
    @kid = Ticket.find(3)
    @inf = Ticket.find(4)
    @adu_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, "1").count
    @mid_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, "2").count
    @kid_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, "3").count
    @inf_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, "4").count
    @reservationdetails = Reservationdetail.where(res: @reservation.id)
  end

  def search
    @reservations = Reservation.search(params[:q]).page(params[:page]).per(15)
    render "index"
  end

  def updtime
    @reservations = Reservation.all.order(confirm_time: :desc)
        .page(params[:page]).per(15)
  end

  def confirm
    @reservations = Reservation.all.where("status = 1").order(confirm_time: :desc)
        .page(params[:page]).per(15)
  end

  def nonconfirm
    @reservations = Reservation.all.where("status = 0").order(confirm_time: :desc)
        .page(params[:page]).per(15)
  end
end
