class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :load_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  def index
    @pagy, @users = pagy(User.newest, page: params[:page],
items: Settings.pagy.items)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      reset_session
      log_in @user
      remember @user
      flash[:success] = t(".success")
      redirect_to @user, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t(".success")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".fail")
    end
    redirect_to users_path
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
    unless logged_in? # rubocop:disable Style/GuardClause
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    return if current_user? @user

    flash[:error] = "You cannot edit this account."
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user&.admin?
  end
end
