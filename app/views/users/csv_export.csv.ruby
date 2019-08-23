require 'csv'

# CSVヘッダー
  csv_headers = ['item_url', 'item_good', 'item_title', 'item_price', 'item_description','item_type','item_image1','item_image2','item_image3','item_image4','item_image5','item_image6','item_image7','item_image8','item_image9','item_image10','item_category','item_brand','item_postage','item_days_to_ship']
  hash = Hash.new { |h,k| h[k] = {} }
 
  item_count = Item.count - 1
  item_data = Item.pluck(:item_url,:item_good,:item_title,:item_price,:item_description,:item_type,:item_image1,:item_image2,:item_image2,:item_image3,:item_image4,:item_image5,:item_image6,:item_image7,:item_image8,:item_image9,:item_image10,:item_category,:item_brand,:item_postage,:item_days_to_ship)
  
  (0..item_count).each do |array_number|
  item_array_number =+ 1
  hash = hash.merge(array_number => item_data[array_number])
  end
  
  bom = "\uFEFF"
    csv_data = CSV.generate(bom) do |csv|
      csv << csv_headers
      (0..item_count).each do |array_number|
        csv_column_values = [
        hash[array_number][0],
        hash[array_number][1],
        hash[array_number][2],
        hash[array_number][3],
        hash[array_number][4],
        hash[array_number][5],
        hash[array_number][6],
        hash[array_number][7],
        hash[array_number][8],
        hash[array_number][9],
        hash[array_number][10],
        hash[array_number][11],
        hash[array_number][12],
        hash[array_number][13],
        hash[array_number][14],
        hash[array_number][15],
        hash[array_number][16],
        hash[array_number][17],
        hash[array_number][18],
        hash[array_number][19]
      ]

      csv << csv_column_values
      end
    end
