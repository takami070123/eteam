class RankingsController < ApplicationController
  def index
    @users = User.order(high_score: :desc)
  end
end