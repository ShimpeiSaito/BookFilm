class Schedule < ApplicationRecord
    belongs_to :mov, class_name: "Movie", foreign_key: "movie_id"
    belongs_to :thea, class_name: "Theater", foreign_key: "theater_id"
end
