class Movie < ApplicationRecord
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
