class StaticPagesController < ApplicationController
  #もしログイン中なら自動的にユーザーページに遷移する
  def top
     if session[:user_id].present? && logged_in?
       user = User.find_by(id: session[:user_id])
     redirect_to user
     end
  end
end
