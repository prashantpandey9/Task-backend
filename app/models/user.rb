class User < ApplicationRecord   
    has_secure_password
    validates :email, uniqueness: true, presence: true
    validates :password, presence: true
    belongs_to :advertisement, class_name: "advertisement", foreign_key: "advertisement_id"
end

