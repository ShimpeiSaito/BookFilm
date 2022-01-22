class Admin::TopController < Admin::Base
  #before_action :admin_login_required

  def index
    if current_member.class.name == "Member" then
      cookies.delete(:member_id)
    end
  end
end
