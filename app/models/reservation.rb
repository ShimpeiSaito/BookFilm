class Reservation < ApplicationRecord
    belongs_to :mem, class_name: "Member", foreign_key: "member_id"
    belongs_to :sche, class_name: "Schedule", foreign_key: "schedule_id"
    has_many :reservationdetails, dependent: :destroy

    class << self
        def search(query)
            rel = order(confirm_time: :desc)
            if query.present?
                movies = Movie.all()
                reservations = Reservation.all()
                check = 0
                for mov in movies do
                    for res in reservations do
                        title = res.sche.mov.title
                        if title.include?("#{query}") then
                            check = check + 1
                            rel = rel.where(id: res.id)
                        end
                    end
                end
            end
            if check == 0 then
                rel = rel.where("status = 10")
            end
            rel
        end
    end
end
