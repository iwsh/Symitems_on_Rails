class AuthenticationsController < ApplicationController
  def login
    @request_auth = {}
    @request_auth[:email] = ''
  end

  def logout
    session[:user] = nil
  end

  def checkUser
    email = params[:email]
    password = params[:password]
    @request_auth = {}
    @request_auth[:email] = email
    @request_auth[:password] = ''

    unless validation(email, password)
      return render :login
    end

    user = User.find_by(email: email)
    if user
      if user.fails_count >= 3
        flash.now[:alert] = 'アカウントロックされています。解除するためには、管理者に問い合わせてください。'
        render :login
      elsif user.authenticate(password)
        session[:user] = user
        user.update(fails_count: 0, last_login_at: DateTime.now, record_timestamps: false)
        redirect_to '/calendar'
      else
        user.increment!(:fails_count)
        if user.fails_count < 3
          flash.now[:alert] = 'Email または Password が違います。'
          render :login
        else
          flash.now[:alert] = 'アカウントがロックされました。解除するためには、管理者に問い合わせてください。'
          render :login
        end
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
      flash.now[:alert] = 'Password を入力してください。'
    end
    flag
  end
end

class RequestAuth < ApplicationRecord
  validates :terms_of_service, acceptance: true
end
