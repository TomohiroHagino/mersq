class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:delete]

  def new
    @item = Item.new
  end

  def update
    @user = User.new
  end

  def create
  end

  def delete
    item_number_list = Item.where(user_id: params[:id]).pluck(:id)
    array = []
    # send_delete_signが"1"になっているitem_idをピックアップ
    item_number_list.each do |item_number|
      if params["items"]["#{item_number}"]["send_delete_sign"] == "1"
      array.push(item_number)
      end
    end
    Item.where(id: array).delete_all
    flash[:success] = '商品を削除しました。'
    redirect_to user_path
  end

      # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
end
