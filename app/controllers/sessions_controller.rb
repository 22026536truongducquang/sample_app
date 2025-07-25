class SessionsController < ApplicationController
  REMEMBER_ME_SELECTED = "1".freeze
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)

    if user&.authenticate(params.dig(:session, :password))
      # Log the user in and redirect to the user's show page.
      handle_successful_login user
    else
      # Create an error message and re-render the login page.
      handle_failed_login
    end
  end

  def destroy
    log_out
    flash[:success] = t(".logout_success")
    redirect_to root_url, status: :see_other
  end

  def handle_successful_login user
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

  def handle_failed_login
    flash.now[:danger] = t(".invalid_email_or_password")
    render :new, status: :unprocessable_entity
  end
end
