class Endorsement < ActiveRecord::Base
  belongs_to :endorser, :class => 'User', :foreign_key => 'endorser_id'
  belongs_to :endorsee, :class => 'User', :foreign_key => 'endorsee_id'

  validates :endorser_id, :endorsee_id, :skill, presence:true
  validates :skill, length: { minimum: 5}
  validates_uniqueness_of :endorser_id, :scope => [:endorsee_id]
end
