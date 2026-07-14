class SessionsController < ApplicationController
  def new
  end

def create
  user = User.find_by(name: params[:name])

  if user&.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to root_path
  else
    flash[:alert] = "ユーザー名またはパスワードが違います"
    render :new, status: :unprocessable_entity
  end
end
  def destroy
    reset_session
    redirect_to login_path
  end
end