class ApplicationController < ActionController::Base
    private def current_member
        Member.find_by(id: cookies.signed[:member_id]) if cookies.signed[:member_id]  #セッションデータ:member_idに値があればMemberオブジェクトを、なければnilを返す。
    end
    helper_method :current_member

    class LoginRequired < StandardError; end
    class Forbidden < StandardError; end

    private def login_required
        raise LoginRequired unless current_member
    end
end
