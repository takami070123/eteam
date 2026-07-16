class PlayLogsController < ApplicationController
  before_action :require_login

  def index
    logs = PlayLog.where(created_at: 7.days.ago..Time.current)

    @weekly_ranking = logs
      .includes(:user)
      .order(score: :desc)
      .limit(10)

    @my_best = logs
      .where(user_id: current_user.id)
      .order(score: :desc)
      .first

    if @my_best
      @my_rank = logs.where("score > ?", @my_best.score).count + 1
    end
  end
end
