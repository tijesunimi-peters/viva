class User < ApplicationRecord
  has_secure_password
  
  validates :firstname,
            :lastname,
            presence: true

  validates :email,
            presence: true,
            format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
            allow_nil: false,
            uniqueness: true

  validates :password,
            presence: true,
            confirmation: true,
            allow_nil: false,
            length: { minimum: 6 }
end
