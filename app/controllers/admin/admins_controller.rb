class Admin::AdminsController < Admin::Base
  before_action :admin_login_required
  
  def show
    @admin = current_member
  end

  def edit
  end

  def update
  end
end
