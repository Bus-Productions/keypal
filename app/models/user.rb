class User < ActiveRecord::Base
  attr_accessible :active, :level, :number, :stripe_unique

  has_many :keys

  has_many :outbounds

  has_many :requests

end
