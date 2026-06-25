class GamesController < ApplicationController
  WORDS = [
    "isu", "neko", "mimi", "ido",
    "koin", "tonbo", "suzume",
    "muetai", "takoyaki",
    "sa-kasu", "akihabara", "moaizou"
  ]

  def index
    session[:score] ||= 0
    session[:count] ||= 0

    @word = WORDS.sample
    session[:answer] = @word
  end

  def check
    answer = params[:answer]
    correct = session[:answer]

    if answer == correct
      session[:count] += 1
      session[:score] += 100

      if WORDS.index(correct) > 5
        session[:score] += 180
      end

      redirect_to root_path
    else
      session[:final_count] = session[:count]
      session[:final_score] = session[:score]

      redirect_to result_path
    end
  end

  def result
    @count = session[:final_count]
    @score = session[:final_score]

    reset_session
  end
end