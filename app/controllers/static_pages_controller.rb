class StaticPagesController < ApplicationController
  def home
    if logged_in?

      @strategy = current_user.strategies.build
      @strategy_items = current_user.strategy_feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about

  end
  
  def contact
  end
end
