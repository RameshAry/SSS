class StrategiesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy


    def create
        @strategy = current_user.strategies.build(strategy_params)
        @strategy.image.attach(params[:strategy][:image])
        if @strategy.save
            flash[:success] = "Micropost is created"
            redirect_to root_url
        else
            @feed_items = current_user.strategy_feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @strategy.destroy
        flash[:success] = "Strategy deleted"
        if request.referrer.nil? || request.referrer == strategies_url
          redirect_to root_url
        else
          redirect_to request.referrer
        end
    end


    private

    #difining micropost paramas
    def strategy_params
       params.require(:strategy).permit(:content, :image)
    end

    def correct_user
      @strategy = current_user.strategies.find_by(id: params[:id])
      redirect_to root_url if @strategy.nil?
    end
end

