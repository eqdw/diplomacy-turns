class AdminController < ApplicationController
  def index
    @shame_wall = User.all.map{|u| u.turns.active.first}.compact.map{|t| t.orders.blank? ? "#{t.user.login} NEEDS TO PLACE ORDERS" : "#{t.user.login} has placed orders"}
  end


  def next_round
    Turn.active.each do |turn|
      turn.active = false
      turn.save
    end

    initialize_turns

    flash[:notice] = "THE GAME HAS PROGRESSED"
    render :index
  end


  def start_game
    Turn.destroy_all
    initialize_turns
    flash[:notice] = "A NEW GAME HAS BEEN STARTED"
    render :index
  end


private
  def initialize_turns
    User.all.each do |user|
      Turn.create(:user => user, :round => Turn.current_active_round)
    end
  end

end
