class Movie < ApplicationRecord
    has_many :schedules, dependent: :destroy

    class << self
        def search(query, m, w)
            rel = order(:title)
            if query.present?
                rel = rel.where("title LIKE ? OR explanation LIKE ?", 
                    "%#{query}%", "%#{query}%")
            end
            rel
        end
    end
end
