class MembersController < ApplicationController
  before_action :login_required

  def show
    @member = Member.find(current_member)
    #@reservations = Reservation.find(@member.id)
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
