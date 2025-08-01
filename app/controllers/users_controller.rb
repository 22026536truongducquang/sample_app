class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create show)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  def index
    @pagy, @users = pagy(User.recent, page: params[:page],
  items: Settings.pagy.page_10)
  end

  # GET /signup
  def new
    @user = User.new
  end

  # POST /signup
  def create
    @user = User.new user_params
    if @user.save
      send_activation_email
    else
      flash.now[:danger] = t(".error")
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    @page, @microposts = pagy @user.microposts.newest,
                              items: Settings.pagy.page_10
  end

  # GET /users/:id/edit
  def edit; end

  # PATCH/PUT /users/:id
  def update
    if @user.update user_params
      flash[:success] = t(".success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".fail")
    end
    redirect_to users_path
  end

  # GET /users/:id/following
  def following
    @title = t(".title")
    @pagy, @users = pagy @user.following, items: Settings.pagy.page_10
    render :show_follow
  end

  # GET /users/:id/followers
  def followers
    @title = t(".title")
    @pagy, @users = pagy @user.followers, items: Settings.pagy.page_10
    render :show_follow
  end
  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t(".not_found")
    redirect_to root_path, status: :see_other
  end

  def user_params
    params.require(:user).permit(User::USER_PERMIT)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please_login")
    redirect_to login_url
  end

  def correct_user
    return if current_user? @user

    flash[:error] = t(".not_correct_user")
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user&.admin?
  end

  def send_activation_email
    @user.send_activation_email
    flash[:info] = t(".check_email")
    redirect_to root_path, status: :see_other
  rescue StandardError
    flash[:danger] = t(".email_error")
    redirect_to root_path, status: :see_other
  end
end
