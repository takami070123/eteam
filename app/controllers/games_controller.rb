class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:finish]
  before_action :require_login

  LIMIT_TIME = 30

  def start_game
    session[:score] = 0
    session[:count] = 0
    session[:miss]  = 0

    redirect_to game_path
  end

  def index
    @words = Word.pluck(:word)
    @limit_time = LIMIT_TIME
  end

  def finish
    Rails.logger.info "=== FINISH PARAMS === #{params.inspect}"
    score   = params[:score].to_i
    correct = params[:correct_count].to_i
    miss    = params[:miss_count].to_i

    PlayLog.create!(
      user_id: session[:user_id],
      score: score,
      correct_count: correct,
      miss_count: miss
    )

    user = User.find(session[:user_id])

    if user.high_score.nil? || score > user.high_score
      user.update(
        high_score: score,
        high_score_date: Time.current
      )
    end

    session[:last_score]   = score
    session[:last_correct] = correct
    session[:last_miss]    = miss

    redirect_to result_path
  end

  def result
  @score = session[:last_score]
  @correct = session[:last_correct]
  @miss = session[:last_miss]
end
end

