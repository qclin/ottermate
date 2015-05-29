class Endorsement < ActiveRecord::Base
  belongs_to :endorser, :class => 'User', :foreign_key => 'endorser_id'
  belongs_to :endorsee, :class => 'User', :foreign_key => 'endorsee_id'

  validates :endorser_id, :endorsee_id, :skill, presence:true
  validates :skill, inclusion: { in: %w(handy neatfreak foodie active punctual lowkey),
    message: "%{value} is not a valid gender" }
end
