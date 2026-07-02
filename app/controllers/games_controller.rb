class GamesController < ApplicationController
  WORDS = [
    "f" , "j"
    # "isu", "neko", "mimi", "ido", "takami", 
    # "koin", "tonbo", "suzume", "ueda",
    # "muetai", "takoyaki", "kanetsuki",
    # "sa-kasu", "akihabara", "moaizou"
  ]

  LIMIT_TIME = 30

  # スタート画面
  def start
  end

  # ゲーム開始
  def start_game
    session[:score] = 0
    session[:count] = 0
    session[:miss] = 0

    redirect_to game_path
  end

  # ゲーム画面
  def index
    @words = WORDS
    @limit_time = LIMIT_TIME
  end
  # ゲーム終了
  def finish
    session[:score] = params[:score].to_i
    session[:count] = params[:count].to_i
    session[:miss]  = params[:miss].to_i

    save_result

    head :ok
  end

  # 結果画面
  def result
    @score = session[:score]
    @count = session[:count]
    @miss  = session[:miss]

    reset_session
  end

  def finish
    session[:score] = params[:score].to_i
    session[:count] = params[:count].to_i
    session[:miss]  = params[:miss].to_i

    save_result

    head :ok
  end

  private

  def save_result
    return unless session[:user_id]

    user = User.find_by(id: session[:user_id])
    return unless user

    if session[:score] > user.high_score.to_i
      user.update(
      high_score: session[:score],
      high_score_date: Time.current
      )
    end  
  end
end