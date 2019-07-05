class User < ApplicationRecord
  # befoore_saveメソッド 大文字の混ざったemailが登録されたら小文字に修正。
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  # emailの正規表現 8行目で使用
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end