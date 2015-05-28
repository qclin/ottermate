class Chat < ActiveRecord::Base
  validates :from_id, :to_id, numericality:true 
  validates :msg, length: {minimum: 1}
end
