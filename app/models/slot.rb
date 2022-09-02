class Slot < ApplicationRecord

    #Association
    belongs_to :floor

    #validations
    validates :slot, presence: true                
    validates :car_no, presence: true
    validates :name, presence: true
    validates :status, presence: true
    validates :floor_id, presence: true

end 