class Movie < ApplicationRecord
    has_many :schedules, dependent: :destroy

    validates :title, presence: { message: "を入力してください" }
    validates :explanation, presence: { message: "を入力してください" }
    validates :released_at, presence: { message: "を指定してください" }
    validates :expired_at, presence: { message: "を指定してください" }
    validates :screening_time, presence: { message: "を指定してください" }, numericality: {only_integer: true, greater_than_or_equal_to: 1, message: "は1以上を指定してください"}

    class << self
        def search(query)
            rel = order(:title)
            if query.present?
                rel = rel.where("title LIKE ?", "%#{query}%")
            end
            rel
        end
    end
end
