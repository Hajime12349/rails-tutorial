class SessionsController < ApplicationController
  def new
  end

  def create
    user=User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        #pass
    else
      flash.now[:danger] = 'Invalid data'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy

  end
end
