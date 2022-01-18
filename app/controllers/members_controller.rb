class MembersController < ApplicationController
  before_action :login_required

  def show
    @member = Member.find(current_member)
    #@reservations = Reservation.find(@member.id)
  end

  #会員の新規登録
  def create
    @member = Member.new(member_params)
    if @member.save
        redirect_to [:admin, @member], notice: "会員を登録しました。"
    else
        render "new"
    end
  end
end
