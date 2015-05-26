class Room < ActiveRecord::Base
  belongs_to :owner, :class => 'User', :foreign_key => 'owner_id'
  has_many :RoomReview

  validates :description, :price, :photo_url, :neighborhood
  validates :description, length: {in: 10..400}
end
