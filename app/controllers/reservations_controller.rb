class ReservationsController < ApplicationController
  before_action :admin_logout
  before_action :login_required

  before_action only: [:new] do
    schedule = Schedule.find(params[:scheid])
    allres = Reservation.where(sche: schedule.id).where("status = ? and confirm_time < ?", 0, Time.now - 30 * 60)
    if allres.nil? == false then
      for kilres in allres do
        kilres.destroy
      end
    end
  end

  def new
    @schedule = Schedule.find(params[:scheid])
    @adu_amo = Ticket.find(1)
    @mid_amo = Ticket.find(2)
    @kid_amo = Ticket.find(3)
    @inf_amo = Ticket.find(4)
  end

  def update
    flag = false
    @reservation = Reservation.find(params[:reservation][:id])
    reservationdetails = Reservationdetail.where(res: @reservation.id)
    for resdet in reservationdetails do
      if Reservationdetail.find_by(seat: resdet.seat).nil? == false then
        otherresdets = Reservationdetail.where(seat: resdet.seat)
        for otherresdet in otherresdets do
          if otherresdet.res.status == 1 && otherresdet.res.sche.id == resdet.res.sche.id then
            flag = true
            break
          end
        end
      end
      if flag == true then
        break
      end
    end
    
    if flag == false then
      @reservation.confirm_time = (Time.zone.now + 9 * 60 * 60).to_s(:db)
      @reservation.status = 1
      if @reservation.save
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
      else
        redirect_to :root, notice: "エラーが発生しました。申し訳ございませんが最初からやり直してください。"
      end
    else
      redirect_to new_reservation_path(scheid: @reservation.sche.id), notice: "エラーが発生しました。申し訳ございませんがチケットの枚数を指定して、再度座席を選択してください。"
    end
  end

  def step1
    adu_amo = params[:adu_sheets].to_i
    mid_amo = params[:mid_sheets].to_i
    kid_amo = params[:kid_sheets].to_i
    inf_amo = params[:inf_sheets].to_i
    totalsheets = adu_amo + mid_amo + kid_amo + inf_amo
    if totalsheets <= 0
      redirect_to new_reservation_path(scheid: params[:scheid]), notice: "チケットの枚数を指定してください。"
    else
      schedule = Schedule.find(params[:scheid])
      sheets = params[:adu_sheets].to_i + params[:mid_sheets].to_i + params[:kid_sheets].to_i + params[:inf_sheets].to_i
      adu = Ticket.find(1)
      mid = Ticket.find(2)
      kid = Ticket.find(3)
      inf = Ticket.find(4)
  
      totalamount = adu.total * adu_amo + mid.total * mid_amo + kid.total * kid_amo + inf.total * inf_amo
      @reservation = Reservation.new(mem: current_member, sche: schedule, payment: current_member.payment, ticket_sheets: sheets, total_sheets: totalamount, status: 0)
      @reservation.confirm_time = (Time.zone.now + 9 * 60 * 60).to_s(:db)
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
        @reservation.confirm_time = (Time.zone.now + 9 * 60 * 60).to_s(:db)
      else
        redirect_to :root, notice: "エラーが発生しました。申し訳ございませんが最初からやり直してください。"
      end
  
      @quantity = {adu: adu_amo, mid: mid_amo, kid: kid_amo, inf: inf_amo}
    end
  end

  def step2
    resds = Reservationdetail.where(res: params[:reservation][:id]).count
    unless params[:seats].nil? || params[:seats].keys.size < resds
      @reservation = Reservation.find(params[:reservation][:id])
      @reservationdetails = Reservationdetail.where(res: params[:reservation][:id])
      @reservation.confirm_time = (Time.zone.now + 9 * 60 * 60).to_s(:db)

      if @reservation.save then
        seat_amo =  params[:seats].keys.size
        seats = params[:seats].keys
        idx = 0
        for resd in @reservationdetails do
          if seat_amo > 0 then
            resd.seat = seats[idx]
            resd.save
          end
          seat_amo -= 1
          idx += 1
        end
        @member = Member.find(@reservation.mem.id)
      else
        redirect_to :root, notice: "エラーが発生しました。申し訳ございませんが最初からやり直してください。"
      end
    else
      @reservation = Reservation.find(params[:reservation][:id])
      redirect_to new_reservation_path(scheid: @reservation.sche.id), notice: "チケットの枚数を指定して、再度座席を選択してください。"
    end
  end

  def step3
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.confirm_time = (Time.zone.now + 9 * 60 * 60).to_s(:db)
    if @reservation.save then
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
    else
      redirect_to :root, notice: "エラーが発生しました。申し訳ございませんが最初からやり直してください。"
    end
  end
end
