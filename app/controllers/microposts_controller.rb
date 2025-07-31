class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  # POST /microposts
  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t(".created")
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed, items: Settings.pagy.page_10
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  # DELETE /microposts/:id
  def destroy
    if @micropost.destroy
      flash[:success] = t(".deleted")
    else
      flash[:danger] = t(".delete_failed")
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(Micropost::MICROPOST_PERMITTED)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please_login")
    redirect_to login_url
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t(".invalid")
    redirect_to request.referer || root_url
  end
end
