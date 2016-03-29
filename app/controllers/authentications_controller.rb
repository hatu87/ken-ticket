class AuthenticationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :failure]
  def create
    # binding.pry

    if user = User.from_omniauth(env["omniauth.auth"])
      # log in user here
      # binding.pry
      # current_user = user
      sign_in user
      redirect_to root_path
    else
      # don't log user in
      flash[:error] = 'Your account is not existed. Please sign in with the Facebook account with its email in our system.'
      redirect_to new_user_session_path
    end
  end

  def failure
    # binding.pry
    flash[:error] = 'Error in loggin with facebook.'
    redirect_to new_user_session_path
  end


end
