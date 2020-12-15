class MarketsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy


    def create
        @market = current_user.markets.build(market_params)
        @market.image.attach(params[:market][:image])
        if @market.save
            flash[:success] = "market is created"
            redirect_to root_url
        else
            @feed_items = current_user.market_feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @market.destroy
        flash[:success] = "Market deleted"
        if request.referrer.nil? || request.referrer == markets_url
          redirect_to root_url
        else
          redirect_to request.referrer
        end
    end


    private

    #difining micropost paramas
    def market_params
       params.require(:market).permit(:content, :image)
    end

    def correct_user
      @market = current_user.markets.find_by(id: params[:id])
      redirect_to root_url if @market.nil?
    end
end

