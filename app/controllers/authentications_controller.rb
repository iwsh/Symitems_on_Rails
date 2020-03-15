class AuthenticationsController < ApplicationController
  def login
    @request_auth = {}
    @request_auth[:email] = 'email here'
  end

  def logout
    session[:user] = nil
  end

  def checkUser
    email = params[:email]
    password = params[:password]
    @request_auth = {}
    @request_auth[:email] = email
    @request_auth[:password] = password

    unless validation(email, password)
      flash.now[:danger] = 'Email/Passwordを入力してください'
      return render :login
    end
    
    user = User.find_by(email: email)
    puts user

    if user
      if user.password == password
        session[:user] = user
        redirect_to '/calendar'
      else
        flash.now[:danger] = 'パスワードが違います'
        render :login
      end
    else
      flash.now[:danger] = 'ユーザが存在しません'
      render :login
    end
  end

  def validation(email, password)
    flag = true
    if email == ''
      flag = false
    end
    if password == ''
      # flash.now[:danger] = 'passwordを入力してください'
      flag = false
    end
    flag
  end
end

class RequestAuth < ApplicationRecord
  validates :terms_of_service, acceptance: true
end
