class Reservationdetail < ApplicationRecord
    belongs_to :res, class_name: "Reservation", foreign_key: "reservation_id"
    belongs_to :tic, class_name: "Ticket", foreign_key: "ticket_id"
end
