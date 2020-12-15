class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @overview_items = current_user.overview_feed.paginate(page: params[:page])
      @advisor  = current_user.advisors.build
      @advisor_items = current_user.advisor_feed.paginate(page: params[:page])
      @market  = current_user.markets.build
      @market_items = current_user.market_feed.paginate(page: params[:page])
      @strategy  = current_user.strategies.build
      @strategy_items = current_user.strategy_feed.paginate(page: params[:page])
      @keyitem  = current_user.keyitems.build
      @keyitem_items = current_user.keyitem_feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about

  end
  
  def contact
  end

  def projects
  end
end
