class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_url(current_user)
    else
      redirect_to dishes_url
    end
  end
end
