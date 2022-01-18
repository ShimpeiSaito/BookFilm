class Screen < ApplicationRecord
    belongs_to :thea, class_name: "Theater", foreign_key: "theater_id"
end
