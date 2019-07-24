class UsersController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  # スクレイプアクション
  def scrape
    # スクレイピング先のURLをここに入れる
    url = URI.encode "https://www.mercari.com/jp/search/?keyword=" + "#{params[:xxx]}"

    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # 配列を作るための準備
    @item_no ||= 0
    # アイテムナンバーの配列を作る準備
    @item_number_list = [@item_no]
    hash = Hash.new { |h,k| h[k] = {} }

    # htmlをパース(解析)してオブジェクトを作成
    doc = Nokogiri::HTML.parse(html, nil, charset)

       doc.xpath('//section[@class="items-box"]').each do |node|

       sold = node.css('figcaption').css('div').inner_text == "SOLDSOLD"

       @item_no += 1
       # タイトル
       @item_title = node.css('h3').inner_text unless sold
       # リンク
       @item_url = node.css('a').attribute('href').value unless sold
       # イメージ
       @item_image = node.css('img').attribute('data-src').value unless sold
       # 金額（から￥とカンマを削除したもの）
       @item_price = node.css('div').children.children.children[0].inner_text.gsub("¥", "").gsub(",","").gsub(" ","")   unless sold


       hash["#{@item_no}"]["item_title"] = @item_title
       hash["#{@item_no}"]["item_image"] = @item_image
       hash["#{@item_no}"]["item_url"] = @item_url
       hash["#{@item_no}"]["item_price"] = @item_price

       @item_number_list.push("#{@item_no}")
       end
     # 配列先頭余分の0を消す
     @item_number_list.delete(0)
     # N+1問題の解決はカラムごとの配列を作って、update
     items = []
       @item_number_list.each do |item_number|
       items << Item.new(:item_title => hash[item_number]["item_title"].to_s,
                        :item_image => hash[item_number]["item_image"].to_s,
                        :item_url => hash[item_number]["item_url"].to_s,
                        :item_price => hash[item_number]["item_price"].to_i)
       end
       Item.import items
    redirect_to root_url
  end

  def how_to_use
    @user = User.find(params[:id])
  end

  #ユーザー新規登録
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
