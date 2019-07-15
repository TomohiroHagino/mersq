module ApplicationHelper

  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "メルスク"
    if page_name.empty?
      base_title # 引数page_nameが空文字の場合はbase_titleのみ返す
    else
      page_name + " | " + base_title # 文字列を連結して返す
    end
  end
end
