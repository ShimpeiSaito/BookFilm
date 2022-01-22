class Member < ApplicationRecord
    has_secure_password

    has_many :reservationdetails, dependent: :destroy

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }

    validates :login_id, presence: { message: "を入力してください" }, uniqueness: true

    validates :name, presence: { message: "を入力してください" },
        format: { with: /\A[ぁ-んァ-ン一-龥a-zA-Z]+\z/, allow_blank: true, message: "は空白なし、ひらがな,カタカナ,漢字,英文字のみで入力してください。" }
    validates :tel, presence: { message: "を入力してください" }, 
        format: { with: /\A[0-9-()]+\z/, allow_blank: true, message: "は8文字以上20文字以下の()と-と数字のみで入力してください。"},
        length: { minimum: 8, maximum: 20 }
    validates :birthday, presence: { message: "を選択してください" }
    validate :day_after_today
        def day_after_today
            unless birthday == nil
                errors.add(:birthday, 'は今日を含む過去の日付を入力してください。') if birthday > Date.today
            end
        end
    validates :email, presence: { message: "を入力してください" }, format: {  with: /\A^\S+@\S+\.\S+$\z/, allow_blank: true, message: "は不正な値です。" }
    validates :payment, presence: { message: "を入力してください" }, format: {  with: /\A[0-9- ]+\z/, allow_blank: true, message: "は不正な値です。" }
end
