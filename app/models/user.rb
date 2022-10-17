class User < ApplicationRecord

  before_save { self.email = email.downcase}

  #Association
  has_one :slot

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  
VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

#validations
validates :email, presence: true,
                     length: {minimum: 5, maximum: 105},
                     uniqueness: {case_sensitive: false},
                     format: { with: VALID_EMAIL_REGEX }

validates :password, presence: true,
                        length: {minimum: 5, maximum: 20}

validates :name, presence: true

validates :role, presence: true

#validates :slot_id, presence: true
end