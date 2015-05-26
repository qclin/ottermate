class User < ActiveRecord::Base
has_secure_password

has_one :room 
has_many :roomReviews, dependant: :destroy
has_many :UserEndorsements, dependant: :destroy


validates :name, :price, :email, :phone, :password, presence:true
validates :email, uniqueness: true
validates :price, :phone, numericality: true
validates :gender, inclusion: {in: (male, female), 
  message: "%{value} is not a valid gender"}

end
