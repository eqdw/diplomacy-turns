class AdminController < ApplicationController
  before_filter :initialize_shamewall

  def index; end

  def next_round
    Turn.active.each do |turn|
      turn.active = false
      turn.save
    end

    initialize_turns

    flash[:notice] = "THE GAME HAS PROGRESSED"
    redirect_to current_round_path
  end


  def config_game
    @users = User.all # if this is more than 7 people yer doin' it wrong
  end

  def start_game
    Turn.destroy_all
    initialize_turns
    initialize_nations
    flash[:notice] = "A NEW GAME HAS BEEN STARTED"
    redirect_to turns_path
  end


private
  def initialize_nations
    binding.pry
    User.all.each do |user|
      user.nation = nil
      user.alive  = false
      user.save!
    end
    binding.pry
    User::NATIONS.each do |nation|
      next if params[nation].blank?
      user = User.find(params[nation])
      user.nation = nation
      user.alive  = true
      user.save!
    end
  end

  def initialize_turns
    User.all.each do |user|
      Turn.create(:user => user, :round => Turn.current_active_round)
    end
  end
  def initialize_shamewall
    @shame_wall = Turn.active.map do |t|
      if !t.user.alive 
        [t.user.email, :dead]
      elsif t.orders.blank?
        [t.user.email, :shame]
      else
        [t.user.email, :noshame]
      end
    end
  end
end
