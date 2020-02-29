class StabAuthenticationsController < ApplicationController
  def login
  end

  def checkUser
    redirect_to '/calendar'
  end

  def logout
  end
end
