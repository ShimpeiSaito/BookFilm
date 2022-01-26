class Reservation < ApplicationRecord
    belongs_to :mem, class_name: "Member", foreign_key: "member_id"
    belongs_to :sche, class_name: "Schedule", foreign_key: "schedule_id"
    has_many :reservationdetails, dependent: :destroy

    class << self
        def search(query)
            rel = where("status = ?", "10")
            if query.present?
                movies = Movie.where("title LIKE ?", "%#{query}%")
                if movies.present? then
                  schedules = []
                  for movie in movies do
                    unless (Schedule.find_by(mov: movie.id)).nil?
                      sches = Schedule.where(mov: movie.id)
                      for sche in sches do
                        schedules.push(sche.id)
                      end
                    end
                  end
                  if schedules.present? then
                    idx = 0
                    for schedule in schedules do
                      rel = rel.or(where("schedule_id = ?", schedules[idx]))
                      idx = idx + 1
                    end
                  end
                end
                rel.order(confirm_time: :desc)
            else
                rel = all.order(confirm_time: :desc)
            end
            
        end
    end
end
