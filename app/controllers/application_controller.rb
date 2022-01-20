class ApplicationController < ActionController::Base
    private def current_member
        if cookies.signed[:member_id]
            Member.find_by(id: cookies.signed[:member_id])   #セッションデータ:member_idに値があればMemberオブジェクトを、なければnilを返す。
        elsif cookies.signed[:admin_id]
            Admin.find_by(id: cookies.signed[:admin_id])
        end
    end
    helper_method :current_member

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    private def login_required
        raise LoginRequired unless current_member
    end

    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end
    
    rescue_from LoginRequired, with: :rescue_login_required
    rescue_from Forbidden, with: :rescue_forbidden
    
    private def rescue_bad_request(exception)
        render "errors/bad_request", status: 400, layout: "error",
            formats: [:html]
    end
    
    private def rescue_login_required(exception)
        store_location
        render "errors/login_required", status: 403, layout: "error",
            formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error",
            formats: [:html]
    end

    private def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error",
            formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error",
            formats: [:html]
    end

    # 記憶したURL (もしくはデフォルト値) にリダイレクト
    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end
  
    # アクセスしようとしたURLを覚えておく
    def store_location
      session[:forwarding_url] = request.url if request.get?
    end
end
