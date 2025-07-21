class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("welcome_to_the_sample_app!")
      redirect_to @user, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = "Not found user!"
    redirect_to root_path
  end

  def index; end

  def destroy; end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
