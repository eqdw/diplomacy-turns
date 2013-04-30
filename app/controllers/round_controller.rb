class RoundController < ApplicationController
  def index
    current_round = Turn.current_inactive_round
    @turns = Turn.where(:round => current_round)
  end
end
