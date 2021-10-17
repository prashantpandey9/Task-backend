class Advertisement < ApplicationRecord
    has_many :comments
    validates :title, presence: true
    validates :body, presence: true
end
