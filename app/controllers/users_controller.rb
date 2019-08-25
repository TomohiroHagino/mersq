class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:index, :edit, :update]
  before_action :admin_user, only: :destroy

  require 'csv'

  def index
    @user = current_user
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @item_all_to_array = Item.all.to_a
  end

  def new
    @user = User.new
  end

  # スクレイプアクション
  def scrape
    unless params[:keyword].include?("https://www.mercari.com/jp/search/?")
      flash[:danger] = '入力するURLは特定の条件を満たす必要があります。'
    return redirect_to user_path
    end
    require 'mechanize'

    Item.delete_all
    agent = Mechanize.new
    page = agent.get("#{params[:keyword]}")
    user = User.find(params[:id])
       
    # 配列を作るための準備
    @item_no ||= 0
    # アイテムナンバーの配列を作る準備
    @item_number_list = [@item_no]
    hash = Hash.new { |h,k| h[k] = {} }

    doc = page.search('//section[@class="items-box"]')
    doc.each do |node|
      sold = node.css('figcaption').css('div').inner_text == "SOLDSOLD"
      @item_no += 1

      # リンク(売り切れでないもの)
      @item_url = node.css('a').attribute('href').value unless sold
      hash["#{@item_no}"]["item_url"] = @item_url
      @item_number_list.push("#{@item_no}")

      # さらに追跡したURL
      trace_page = agent.get("#{@item_url}")
      node = trace_page.search('//section[@class="item-box-container l-single-container"]')

      # 商品名
      node = trace_page.search('//section[@class="item-box-container l-single-container"]')
      @item_title = node.css('h1').inner_text if node.css('h1')[0].present?
      # いいねの数
      node = trace_page.search('//div[@class="item-button-container clearfix"]')
      @item_good = node.css('span')[1].children.inner_text

      # 金額 item-price-box text-center visible-sp
      node = trace_page.search('//div[@class="item-price-box text-center"]')
      @item_price = node.css('span')[0].inner_text.gsub("¥","").gsub(" ","").gsub(",","") if node.css('span')[0].present?

      # 説明文
      node = trace_page.search('//div[@class="item-description f14"]')
      @item_description = node.css('p')[0].children.inner_text.gsub("\n","") if node.css('p')[0].children.present?

      # 状態
      node = trace_page.search('//table[@class="item-detail-table"]')
      @item_type = node.css('td')[3].children.inner_text

      # イメージの数
      node = trace_page.search('//section[@class="item-box-container l-single-container"]')
      @item_image_1 = node.css('img')[0].attribute('data-src').inner_text if node.css('img')[0].present?
      @item_image_2 = node.css('img')[1].attribute('data-src').inner_text if node.css('img')[1].present?
      @item_image_3 = node.css('img')[2].attribute('data-src').inner_text if node.css('img')[2].present?
      @item_image_4 = node.css('img')[3].attribute('data-src').inner_text if node.css('img')[3].present?
      @item_image_5 = node.css('img')[4].attribute('data-src').inner_text if node.css('img')[4].present?
      @item_image_6 = node.css('img')[5].attribute('data-src').inner_text if node.css('img')[5].present?
      @item_image_7 = node.css('img')[6].attribute('data-src').inner_text if node.css('img')[6].present?
      @item_image_8 = node.css('img')[7].attribute('data-src').inner_text if node.css('img')[7].present?
      @item_image_9 = node.css('img')[8].attribute('data-src').inner_text if node.css('img')[8].present?
      @item_image_10 = node.css('img')[9].attribute('data-src').inner_text if node.css('img')[9].present?

      # カテゴリー
      node = trace_page.search('//table[@class="item-detail-table"]')
      @item_category = node.css('td')[1].children.children.inner_text.gsub("\n", ">").gsub(" ","").gsub(">>", ">").chop
      # ブランド
      @item_brand = node.css('td')[2].children.inner_text.gsub("\n","").gsub(" ","") if node.css('td')[2].present?
      # 送料について
      @item_postage = node.css('td')[4].children.inner_text.gsub("送料込み(出品者負担)", "0").gsub("着払い(購入者負担)", "1000")
      # 発送までの日数
      @item_days_to_ship = node.css('td')[7].children.inner_text

      hash["#{@item_no}"]["item_good"] = @item_good
      hash["#{@item_no}"]["item_title"] = @item_title
      hash["#{@item_no}"]["item_price"] = @item_price
      hash["#{@item_no}"]["item_description"] = @item_description
      hash["#{@item_no}"]["item_type"] = @item_type
      hash["#{@item_no}"]["item_image1"] = @item_image_1
      hash["#{@item_no}"]["item_image2"] = @item_image_2
      hash["#{@item_no}"]["item_image3"] = @item_image_3
      hash["#{@item_no}"]["item_image4"] = @item_image_4
      hash["#{@item_no}"]["item_image5"] = @item_image_5
      hash["#{@item_no}"]["item_image6"] = @item_image_6
      hash["#{@item_no}"]["item_image7"] = @item_image_7
      hash["#{@item_no}"]["item_image8"] = @item_image_8
      hash["#{@item_no}"]["item_image9"] = @item_image_9
      hash["#{@item_no}"]["item_image10"] = @item_image_10
      hash["#{@item_no}"]["item_category"] = @item_category
      hash["#{@item_no}"]["item_brand"] = @item_brand
      hash["#{@item_no}"]["item_postage"] = @item_postage
      hash["#{@item_no}"]["item_days_to_ship"] = @item_days_to_ship
    end
      
      
      # 配列先頭余分の0を消す
      @item_number_list.delete(0)

      # カラムごとの配列を作って、bulk insert
      items = []
      @item_number_list.each do |item_number|
        items << user.items.new(:item_url => hash[item_number]["item_url"],
                        :item_good => hash[item_number]["item_good"],
                        :item_type => hash[item_number]["item_type"],
                        :item_title => hash[item_number]["item_title"],
                        :item_price => hash[item_number]["item_price"].to_i,
                        :item_description => hash[item_number]["item_description"],
                        :item_image1 => hash[item_number]["item_image1"],
                        :item_image2 => hash[item_number]["item_image2"],
                        :item_image3 => hash[item_number]["item_image3"],
                        :item_image4 => hash[item_number]["item_image4"],
                        :item_image5 => hash[item_number]["item_image5"],
                        :item_image6 => hash[item_number]["item_image6"],
                        :item_image7 => hash[item_number]["item_image7"],
                        :item_image8 => hash[item_number]["item_image8"],
                        :item_image9 => hash[item_number]["item_image9"],
                        :item_image10 => hash[item_number]["item_image10"],
                        :item_category => hash[item_number]["item_category"],
                        :item_brand => hash[item_number]["item_brand"],
                        :item_postage => hash[item_number]["item_postage"],
                        :item_days_to_ship => hash[item_number]["item_days_to_ship"]
                        )
      end
    user.items.import items
    flash[:success] = '商品のスクレイピングに成功しました。'
    redirect_to user_url
  end

  def how_to_use
    @user = User.find(params[:id])
    @youtube_all_to_array = Youtube.all.to_a
  end

  def youtube_scrape
    require 'uri'
    require 'net/http'
    require "json"

    @user = User.find_by(params[:id])

    if params[:keyword].blank?
      flash[:danger] = '空白では検索できません。'
      return redirect_to users_how_to_use_url
    end

    unless @user.search_channel_id && @user.youtube_api
      flash[:danger] = 'この機能を利用するにはAPIキーとチャンネルIDを設定する必要があります。'
      return redirect_to users_how_to_use_url
    end

    Youtube.delete_all
    next_page_token = nil
    
    # APIキーは環境変数で設定
    target = URI.encode_www_form({
              part: "snippet",
              channelId: @user.search_channel_id,
              maxResults: 10,
              pageToken: next_page_token,
              q: "#{params[:keyword]}",
              type: "video",
              key: @user.youtube_api
            })

    uri = URI.parse("https://www.googleapis.com/youtube/v3/search?#{target}")
    puts uri
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.get(uri.request_uri)
    end

    # 例外処理は省略
    @result = JSON.parse(response.body)

    if @result["items"].nil?
      flash[:danger] = 'キーワード検索がヒットしませんでした。APIキーもしくはチャンネルIDが間違っている可能性があります。'
      return redirect_to users_how_to_use_url
    end

    # 配列を作るための準備
    @youtube_no ||= 0
    # アイテムナンバーの配列を作る準備
    @youtube_number_list = [@youtube_no]
    hash = Hash.new { |h,k| h[k] = {} }

    # itemsを参照すれば動画オブジェクトを取得できる
    @result["items"].each do |item|
      @youtube_no += 1
      hash[@youtube_no][:title] = item["snippet"]["title"]
      hash[@youtube_no][:video_url] = item["id"]["videoId"]
      @youtube_number_list.push("#{@youtube_no}")
    end
    # 配列先頭余分の0を消す
    @youtube_number_list.delete(0)
    youtubes = []

    @youtube_number_list.each do |youtube_number|
      youtubes << Youtube.new(:title => hash[youtube_number.to_i][:title],
                              :video_url => hash[youtube_number.to_i][:video_url]
                              )
    end
    Youtube.import youtubes
    flash[:success] = 'youtubeスクレイピングに成功しました！'
    redirect_to users_how_to_use_url
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

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def csv_export
    send_data render_to_string, filename: "#{Time.now.strftime("%Y_%m%d_%H%M%S")}_item_products.csv", type: :csv
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :youtube_api, :search_channel_id)
  end

    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # アクセスしたユーザーが現在ログインしているユーザーか確認します。管理者の場合はアクセス可能
    def correct_user
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
