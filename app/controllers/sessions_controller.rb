class SessionsController < ApplicationController
  def new
    if logged_in?
      if current_user.admin
        redirect_to admin_root_url
      else
        redirect_to root_path
      end
    end
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      user = User.find_or_create_from_auth_hash(auth)
      if user
        log_in user
        flash[:success] = "Wellcome #{user.name}"
      else
        flash[:danger] = "Log in failed"
      end
      redirect_to root_path
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          if current_user.admin
            redirect_to admin_root_url
          else
            redirect_to root_url
          end
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render :new
      end
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
