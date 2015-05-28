class User < ActiveRecord::Base
has_secure_password

has_one :room 
has_many :Reviews, dependent: :destroy
has_many :Endorsements, dependent: :destroy

validates :username, uniqueness: true
validates :username, :name, :email, :phone, :password, presence:true
validates :email, uniqueness: true
validates :phone, length: { is: 10}
validates :gender, inclusion: { in: %w(male female),
    message: "%{value} is not a valid gender" }
end
