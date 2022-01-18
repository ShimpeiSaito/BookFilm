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
    adu_amo = Ticket.find(1)
    mid_amo = Ticket.find(2)
    kid_amo = Ticket.find(3)
    inf_amo = Ticket.find(4)
    totalamount = adu_amo.total * params[:adu_sheets].to_i + mid_amo.total * params[:mid_sheets].to_i + kid_amo.total * params[:kid_sheets].to_i + inf_amo.total * params[:inf_sheets].to_i
    @reservation = Reservation.new(mem: current_member, sche: schedule, payment: current_member.payment, ticket_sheets: sheets, total_sheets: totalamount)
    if @reservation.save
      redirect_to action: :step1,id:@reservation.id
    else
      redirect_to :root, notice: "エラーが発生しました。"
    end
  end

  def step1

  end
end
