class User < ApplicationRecord
  has_secure_password validations: false


  validates :name,
            presence: { message: "を入力してください" }, # 値が入力されているのかチェック
            uniqueness: { message: "は既に使用されています" } # 値が重複されていないかのチェック

  validates :password,
            presence: { message: "を入力してください" }, # 値入力チェック
            length: { minimum: 4, message: "は4文字以上で入力してください" } # 重複チェック
end