class ProgressesController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy


    def create
        @progress = current_user.progresses.build(progress_params)
        @progress.image.attach(params[:progress][:image])
        if @progress.save
            flash[:success] = "Progress is created"
            redirect_to root_url
        else
            @feed_items = current_user.progress_feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @progress.destroy
        flash[:success] = "Progress deleted"
        if request.referrer.nil? || request.referrer == progresses_url
          redirect_to root_url
        else
          redirect_to request.referrer
        end
    end


    private

    #difining micropost paramas
    def progress_params
       params.require(:progress).permit(:content, :image)
    end

    def correct_user
      @progress = current_user.progresses.find_by(id: params[:id])
      redirect_to root_url if @progress.nil?
    end
end

