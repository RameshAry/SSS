class KeyitemsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy


    def create
        @keyitem = current_user.keyitems.build(keyitems_params)
        @keyitem.image.attach(params[:keyitem][:image])
        if @keyitem.save
            flash[:success] = "keyitem is created"
            redirect_to root_url
        else
            @feed_items = current_user.keyitems_feed.paginate(page: params[:page])
            render 'static_pages/home'
        end
    end

    def destroy
        @keyitem.destroy
        flash[:success] = "keyitem deleted"
        if request.referrer.nil? || request.referrer == keyitems_url
          redirect_to root_url
        else
          redirect_to request.referrer
        end
    end


    private

    #difining micropost paramas
    def keyitems_params
       params.require(:keyitem).permit(:content, :image)
    end

    def correct_user
      @keyitem = current_user.keyitems.find_by(id: params[:id])
      redirect_to root_url if @keyitem.nil?
    end
end

