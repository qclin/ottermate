class Review < ActiveRecord::Base
  belongs_to :room 
  belongs_to :reviewer, :class => 'User', :foreign_key => 'reviewer_id'


  validates_uniqueness_of :room_id, :scope => [:reviewer_id]
end
