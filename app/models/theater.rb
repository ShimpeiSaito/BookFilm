class Theater < ApplicationRecord
    has_many :schedules, dependent: :destroy
end
