class TopController < ApplicationController
  before_action :admin_logout
  
  def index
    session.delete(:forwarding_url)
  end
end
