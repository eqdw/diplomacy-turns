class AdminController < ApplicationController
  before_filter :initialize_shamewall, :only => [:index]

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

  def defeat
    user = User.find(params[:user_id])
    user.alive = false
    user.save!
    redirect_to admin_path
  end

private
  def initialize_nations
    User.all.each do |user|
      user.nation = nil
      user.alive  = false
      user.save!
    end
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
    @shame_wall = User.players.map do |p|
      if !p.alive
        [p, :dead]
      elsif p.active_turn.orders.blank?
        [p, :shame]
      else
        [p, :noshame]
      end
   # 
    #@shame_wall = Turn.active.map do |t|
      #if !t.user.alive 
        #[t.user, :dead]
      #elsif t.orders.blank?
        #[t.user, :shame]
      #else
        #[t.user, :noshame]
      #end
    end
  end
end
