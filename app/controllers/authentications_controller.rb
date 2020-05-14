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
      return render :login
    end

    user = User.find_by(email: email)
    if user
      if user.authenticate(password)
        session[:user] = user
        # 該当ユーザのfails_countを0に戻す
        redirect_to '/calendar'
      else
        flash.now[:alert] = 'Email または Password が違います。'
        # 該当ユーザのfails_countをインクリメント
        render :login
      end
    else
      flash.now[:alert] = 'Email または Password が違います。'
      render :login
    end
  end

  def validation(email, password)
    flag = true
    if email == ''
      flag = false
      if password == ''
        flash.now[:alert] = 'Email/Password を入力してください。'
      else
        flash.now[:alert] = 'Email を入力してください。'
      end
    elsif password == ''
      flag = false
      flash.now[:alert] = 'Passwordを入力してください。'
    end
    flag
  end
end

class RequestAuth < ApplicationRecord
  validates :terms_of_service, acceptance: true
end
