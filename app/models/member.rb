class Member < ApplicationRecord
    has_secure_password

    attr_accessor :current_password
    validates :password, presence: { if: :current_password }

    has_many :reservationdetails, dependent: :destroy
end
