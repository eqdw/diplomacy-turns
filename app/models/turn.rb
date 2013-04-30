class Turn < ActiveRecord::Base
  attr_accessible :orders
  has_many :users


  scope :active,   where(:active => true)
  scope :inactive, where(:active => false)

end
