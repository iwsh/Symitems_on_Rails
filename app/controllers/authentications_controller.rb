class AuthenticationsController < ApplicationController
  def login
    @request_auth = {}
    @request_auth[:email] = 'email here'
  end

  def logout
  end

  def checkUser
    email = params[:email]
    password = params[:password]

    @request_auth = Hash.new
    @request_auth[:email] = email
    @request_auth[:password] = password
    
    puts @request_auth
    unless validation(email, password)
      return render :login
    end

    user = User.find_by(email: email)

    # # test
    # user = User.new
    # user.password = password
    if user
      user.password == password ? (redirect_to '/stab/calender') : (render :login)
      # user.password == password ? (redirect_to '/calender') : (render :login)
    else
      render :login
    end
  end

  def validation(email, password)
    true # TODO
  end
end
