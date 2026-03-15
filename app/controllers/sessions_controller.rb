class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the user by their email address
    @user = User.find_by({ "email" => params["email"] })

    # If the user exists, check if they know their password
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        # 3. If they know their password, log them in!
        # We use the session hash to store the user's ID in a browser cookie
        session["user_id"] = @user["id"]
        redirect_to "/places", status: :see_other
      else
        # Password was incorrect
        redirect_to "/sessions/new"
      end
    else
      # User didn't exist
      redirect_to "/sessions/new"
    end
  end


  def destroy
    # Log out the user by clearing the cookie
    session["user_id"] = nil
    redirect_to "/sessions/new", status: :see_other
  end
end
  