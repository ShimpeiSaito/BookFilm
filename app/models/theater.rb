class Theater < ApplicationRecord
    has_many :schedules, dependent: :destroy
    has_many :screens, dependent: :destroy
end
