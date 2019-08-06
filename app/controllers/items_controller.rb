class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def update
    @user = User.new
  end

  def create
  end

  def delete
    item_number_list = Item.pluck(:id)
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
end
