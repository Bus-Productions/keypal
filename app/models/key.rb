class Key < ActiveRecord::Base
  attr_accessible :key, :pass, :user_id

  belongs_to :user
  
end
