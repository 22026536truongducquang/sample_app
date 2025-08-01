class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user, only: %i(create)
  before_action :load_relationship, only: %i(destroy)

  # POST /relationships
  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.turbo_stream
    end
  end

  # DELETE /relationships/:id
  def destroy
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.turbo_stream
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:followed_id])
    return if @user

    flash[:danger] = t(".user_not_found")
    redirect_to root_path
  end

  def load_relationship
    @relationship = Relationship.find_by(id: params[:id])
    return if @relationship

    flash[:danger] = t(".relationship_not_found")
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please_login")
    redirect_to login_url
  end
end
