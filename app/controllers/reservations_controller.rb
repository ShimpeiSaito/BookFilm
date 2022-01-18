class ReservationsController < ApplicationController
  before_action :login_required

  def new
    @schedule = Schedule.find(params[:scheid])
    @adu_amo = Ticket.find(1)
    @mid_amo = Ticket.find(2)
    @kid_amo = Ticket.find(3)
    @inf_amo = Ticket.find(4)
  end

  def create
    schedule = Schedule.find(params[:scheid])
    sheets = params[:adu_sheets].to_i + params[:mid_sheets].to_i + params[:kid_sheets].to_i + params[:inf_sheets].to_i
    adu = Ticket.find(1)
    mid = Ticket.find(2)
    kid = Ticket.find(3)
    inf = Ticket.find(4)
    adu_amo = params[:adu_sheets].to_i
    mid_amo = params[:mid_sheets].to_i
    kid_amo = params[:kid_sheets].to_i
    inf_amo = params[:inf_sheets].to_i

    totalamount = adu.total * adu_amo + mid.total * mid_amo + kid.total * kid_amo + inf.total * inf_amo
    @reservation = Reservation.new(mem: current_member, sche: schedule, payment: current_member.payment, ticket_sheets: sheets, total_sheets: totalamount)
    if @reservation.save
      if adu_amo > 0
        adu_amo.times do
          @reservationdetail = Reservationdetail.new(res: @reservation, tic: adu)
          @reservationdetail.save
        end
      end
      if mid_amo > 0
        mid_amo.times do
          @reservationdetail = Reservationdetail.new(res: @reservation, tic: mid)
          @reservationdetail.save
        end
      end
      if kid_amo > 0
        kid_amo.times do
          @reservationdetail = Reservationdetail.new(res: @reservation, tic: kid)
          @reservationdetail.save
        end
      end
      if inf_amo > 0
        inf_amo.times do
          @reservationdetail = Reservationdetail.new(res: @reservation, tic: inf)
          @reservationdetail.save
        end
      end
      redirect_to action: :step1,id:@reservation.id
    else
      redirect_to :root, notice: "エラーが発生しました。"
    end
  end

  def step1
    @reservation = Reservation.find(params[:id])
    adu_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, 1).count
    mid_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, 2).count
    kid_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, 3).count
    inf_amo = Reservationdetail.where("(reservation_id = ?) and (ticket_id = ?)", @reservation.id, 4).count

    @quantity = {adu: adu_amo, mid: mid_amo, kid: kid_amo, inf: inf_amo}
  end
end
