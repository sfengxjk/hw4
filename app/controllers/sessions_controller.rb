class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}!"
        redirect_to "/places"
      else
        flash["notice"] = "Password not correct."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Email doesn't exist."
      redirect_to "/login"
    end
  end

  def destroy
    flash["notice"] = "You have logged out, goodbye!"
    session["user_id"] = nil
    redirect_to ""
  end
end
  