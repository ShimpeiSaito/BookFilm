class Admin::AdminsessionsController < Admin::Base
    def create
        admin = Admin.find_by(login_id: params[:name])
        if admin&.authenticate(params[:password])
            cookies.signed[:admin_id] = { value: admin.id, expires: 30.minutes.from_now } #10.seconds.from_now
            redirect_to admin_admin_path(admin.id)
        else
            flash.alert = "名前とパスワードが一致しません"
            redirect_back_or(admin_root_path)
        end
    end
    
    def destroy
        cookies.delete(:admin_id)
        redirect_to admin_root_path
    end
end
