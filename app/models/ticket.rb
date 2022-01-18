class Ticket < ApplicationRecord
    has_many :reservationdetails, dependent: :destroy
end
