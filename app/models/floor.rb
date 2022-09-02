class Floor < ApplicationRecord

    #Association
    has_many :slots

    #validations
    validates :floor, presence: true
end