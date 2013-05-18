class Request < ActiveRecord::Base
  attr_accessible :body, :from_number
end
