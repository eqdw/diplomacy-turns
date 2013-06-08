class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  NATIONS = %w{ France Italy Germany Russia Turkey Austria Britain }

  scope :alive, where(:alive => true)
  
  # Allow nil because new users won't have a nation
  # until a game is started
  validates :nation, :inclusion  => { :in => NATIONS, :allow_nil => true }
  validate do |user|
    return true if user.nation.nil?
    users = User.where(:nation => user.nation)
    unless users.length == 0 || (users.length == 1 && users[0] == user)
      errors.add(:base, "Only one player per nation")
    end
  end

  has_many :turns
  
  def active_turn
    self.turns.active
  end
  # attr_accessible :title, :body
end
