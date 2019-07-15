class StaticPagesController < ApplicationController
  def top
    user = params[:session][:id]
    if user.logged_in?
    end
  end
end
