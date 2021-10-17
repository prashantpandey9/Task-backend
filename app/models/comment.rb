class Comment < ApplicationRecord
  belongs_to :advertisement
  validates :user_email, presence: true
  validates :content, presence: true    
  
end
