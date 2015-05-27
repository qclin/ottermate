class Room < ActiveRecord::Base
  belongs_to :owner, :class => 'User', :foreign_key => 'owner_id'
  has_many :Review

  validates :owner_id, :description, :price, :neighborhood, presence: true
  validates :owner_id, :price, numericality: true
  validates :description, length: {in: 10..400}
end
