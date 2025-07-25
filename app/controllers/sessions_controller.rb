class SessionsController < ApplicationController
  before_action :find_user_and_validate, only: [:create]

  REMEMBER_ME_SELECTED = "1".freeze
  def new; end

  def create
    reset_session
    log_in user
    if params.dig(:session,
                  :remember_me) == REMEMBER_ME_SELECTED
      remember(user)
    else
      forget(user)
    end
    flash[:success] = t(".login_success")
    redirect_to user, status: :see_other
  end

  def destroy
    log_out
    flash[:success] = t(".logout_success")
    redirect_to root_url, status: :see_other
  end

  def find_user_and_validate
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)

    return if @user&.authenticate(params.dig(:session, :password))

    flash.now[:danger] = t(".invalid_email_or_password")
    render :new, status: :unprocessable_entity
  end
end
