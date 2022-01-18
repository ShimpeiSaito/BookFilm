class Reservation < ApplicationRecord
    belongs_to :mem, class_name: "Member", foreign_key: "member_id"
    belongs_to :sche, class_name: "Schedule", foreign_key: "schedule_id"
    has_many :reservationdetails, dependent: :destroy
end
