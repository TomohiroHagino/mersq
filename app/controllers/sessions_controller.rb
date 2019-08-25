class SessionsController < ApplicationController
  def new
  end

  #ログイン
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        remember user
        redirect_back_or user
      else
        message  = "アカウントがアクティベーションされていません "
        message += "管理者に連絡をしてアクティベーションをしてもらってください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = '認証に失敗しました。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
