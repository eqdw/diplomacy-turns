class Turn < ActiveRecord::Base
  attr_accessible :orders, :user, :round, :active, :user_id
  belongs_to :user


  scope :active,   where(:active => true)
  scope :inactive, where(:active => false)

  def self.current_inactive_round
    if Turn.all.count == 0
      0
    else
      self.inactive.order("round DESC").first.round
    end
  end
  def self.current_active_round
    if Turn.all.count == 0
      1
    elsif Turn.active.empty? 
      self.current_inactive_round + 1
    else
      Turn.active.first.round
    end
  end

end
