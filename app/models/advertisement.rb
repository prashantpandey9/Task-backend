class Advertisement < ApplicationRecord
    has_many :comments
    validates :title, presence: true
    validates :body, presence: true
    belongs_to :user 
    attribute :is_published, :boolean, default: false
end
