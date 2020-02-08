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
    @request_auth = {}
    @request_auth[:email] = email
    @request_auth[:password] = password

    puts @request_auth
    unless validation(email, password)
      flash.now[:danger] = 'Email/Passwordを入力してください'
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
    flag = true
    if email == ''

      flag = false
    end
    if password == ''
      flash.now[:danger] = 'passwordを入力してください'
      flag = false
    end
    flag
  end
end

class RequestAuth < ApplicationRecord
  validates :terms_of_service, acceptance: true
end
