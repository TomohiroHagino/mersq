class SessionsController < ApplicationController
  def new
  end

  #ログイン
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_back_or user
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
