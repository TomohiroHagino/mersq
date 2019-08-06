class UsersController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'csv'

  def show
    @user = User.find(params[:id])
    @item_all_to_array = Item.all.to_a
  end

  def new
    @user = User.new
  end

  # スクレイプアクション
  def scrape
    Item.delete_all
    # スクレイピング先のURLをここに入れる
    url = URI.encode "#{params[:xxx]}"

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

        # リンク
        @item_url = node.css('a').attribute('href').value unless sold

        hash["#{@item_no}"]["item_url"] = @item_url
        @item_number_list.push("#{@item_no}")
       
        # ここからさらに抜き出したURLにアクセスし、説明文　状態　サイズ　画像1から10　カテゴリー　ブランド　送料込み　発送日数を抽出する
        charset = nil
        html = open(@item_url) do |f|
          charset = f.charset # 文字種別を取得
          f.read # htmlを読み込んで変数htmlに渡す
        end
      
        doc2 = Nokogiri::HTML.parse(html, nil, charset)  
        # 商品名
        node = doc2.xpath('//section[@class="item-box-container l-single-container"]')
        @item_title = node.css('h1').inner_text if node.css('h1')[0].present?
        # いいねの数
        node = doc2.xpath('//div[@class="item-button-container clearfix"]')
        @item_good = node.css('span')[1].children.inner_text

        # 金額 item-price-box text-center visible-sp
        node = doc2.xpath('//div[@class="item-price-box text-center"]')
        @item_price = node.css('span')[0].inner_text.gsub("¥","").gsub(" ","").gsub(",","") if node.css('span')[0].present?

        # 説明文
        node = doc2.xpath('//div[@class="item-description f14"]')
        @item_description = node.css('p')[0].children.inner_text.gsub("\n","") if node.css('p')[0].children.present?

        # 状態
        node = doc2.xpath('//table[@class="item-detail-table"]')
        @item_type = node.css('td')[3].children.inner_text

        # イメージの数
        node = doc2.xpath('//section[@class="item-box-container l-single-container"]')
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
        node = doc2.xpath('//table[@class="item-detail-table"]')
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
      items << Item.new(:item_url => hash[item_number]["item_url"],
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
    Item.import items
    flash[:success] = '商品のスクレイピングに成功しました。'
    redirect_to user_url
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

  def csv_export
    send_data render_to_string, filename: "item_products.csv", type: :csv
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
