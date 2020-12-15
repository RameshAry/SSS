class AdvisorsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy


    def create
        @advisor = current_user.advisors.build(advisor_params)
        @advisor.image.attach(params[:micropost][:image])
        if @advisor.save
            flash[:success] = "Advisor is created"
            redirect_to root_url
        else
            @feed_items = current_user.advisor_feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @advisor.destroy
        flash[:success] = "Advisor deleted"
        if request.referrer.nil? || request.referrer == advisor_url
          redirect_to root_url
        else
          redirect_to request.referrer
        end
    end


    private

    #difining micropost paramas
    def advisor_params
       params.require(:advisor).permit(:content, :image)
    end

    def correct_user
      @advisor = current_user.advisors.find_by(id: params[:id])
      redirect_to root_url if @advisor.nil?
    end
end

