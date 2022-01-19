class SessionsController < ApplicationController
    def create
        member = Member.find_by(login_id: params[:name])
        if member&.authenticate(params[:password])
            cookies.signed[:member_id] = { value: member.id, expires: 20.minutes.from_now } #10.seconds.from_now
        else
            flash.alert = "名前とパスワードが一致しません"
        end
        redirect_back_or(:root)
    end
    
    def destroy
        cookies.delete(:member_id)
        redirect_to :root
    end
end
