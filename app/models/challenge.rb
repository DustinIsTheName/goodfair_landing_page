class Challenge < ApplicationRecord

  validates :email, uniqueness: true
  serialize :friend_email_hashs
  
end
