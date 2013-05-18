class Request < ActiveRecord::Base
  attr_accessible :body, :from_number

  belongs_to :user
end
