class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({"username" => params["username"]})
        if @user
            if BCrypt::Password.new(@user["password"]) == params["password"]
                session["user_id"] = @user["id"]
                flash["notice"] = "You've logged in."
                redirect_to "/"
            else
                flash["notice"] = "Unsuccessful login."
                redirect_to "/sessions/new"
            end

        else
            flash["notice"] = "Unsuccessful login."
            redirect_to "/sessions/new"
        end
  end

  def destroy
    flash["notice"] = "Goodbye."
    session["user_id"] = nil
    redirect_to "/sessions/new"
  end
end
  