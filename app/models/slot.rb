class Slot < ApplicationRecord

    #Association
    belongs_to :floor

    #validations
    validates :slot, presence: true                
    validates :car_no, presence: true #, uniqueness: true
    validates :name, presence: true
    validates :floor_id, presence: true

    scope :search, lambda {|query|where(["car_no LIKE ?","%#{query}%"])}

end 