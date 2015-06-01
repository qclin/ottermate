class Room < ActiveRecord::Base
  belongs_to :owner, :class => 'User', :foreign_key => 'owner_id'
  has_many :Review

  # validates :owner_id, :description, :price, :neighborhood, presence: true
  # validates :owner_id, :price, numericality: true
  # validates :description, length: {in: 10..400}

  # paperclip settings for attached image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing-image-640x360.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end