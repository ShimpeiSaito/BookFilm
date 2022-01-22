class Admin::Base < ApplicationController

    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    private def admin_login_required
      if current_member
        if current_member&.class.name != "Admin"
            raise LoginRequired
        end
      else
        raise LoginRequired
      end
    end

    rescue_from LoginRequired, with: :rescue_admin_login_required
    rescue_from Forbidden, with: :rescue_forbidden

    private def rescue_bad_request(exception)
        render "admin/errors/bad_request", status: 400, layout: "error",
            formats: [:html]
    end
    
    private def rescue_admin_login_required(exception)
        store_location
        redirect_to admin_root_path
    end

    private def rescue_forbidden(exception)
        render "admin/errors/forbidden", status: 403, layout: "error",
            formats: [:html]
    end

    private def rescue_not_found(exception)
        render "admin/errors/not_found", status: 404, layout: "error",
            formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "admin/errors/internal_server_error", status: 500, layout: "error",
            formats: [:html]
    end
  end  