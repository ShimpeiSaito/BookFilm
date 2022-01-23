class Schedule < ApplicationRecord
    belongs_to :mov, class_name: "Movie", foreign_key: "movie_id"
    belongs_to :thea, class_name: "Theater", foreign_key: "theater_id"
    has_many :reservationdetails, dependent: :destroy

    validates :thea, presence: { message: "を選択してください" }
    validates :mov, presence: { message: "を選択してください" }
    validates :screen_no, presence: { message: "を選択してください" }
    validates :screening_date, presence: { message: "を指定してください" }
    validates :starttime, presence: { message: "を指定してください" }

    validate :screen_duplicate_check

    def screen_duplicate_check
        schedules = Schedule.where(thea: self.thea).where(screen_no: self.screen_no)
        unless schedules.nil?
            for sche in schedules do
                if (sche.starttime < self.starttime && self.starttime < sche.endtime) || (sche.starttime < self.endtime && self.endtime < sche.endtime)
                    errors.add(:starttime, "同スクリーンの同時刻に上映があるため登録できません")
                    break
                end
            end
        end
    end

    validate :released_check

    def released_check
      errors.add(:screening_date, "は公開開始日より前の日付は登録できません") if self.screening_date < self.mov.released_at
    end

    validate :expired_check

    def expired_check
      errors.add(:screening_date, "は公開終了日より後の日付は登録できません") if self.screening_date > self.mov.expired_at
    end
end
