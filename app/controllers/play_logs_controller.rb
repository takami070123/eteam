class PlayLogsController < ApplicationController
  def index
    @weekly_ranking = PlayLog
      .where(created_at: 7.days.ago..Time.current)
      .includes(:user)
      .order(score: :desc)
      .limit(10)
  end
end
