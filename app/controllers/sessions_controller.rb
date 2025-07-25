class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)

    if user&.authenticate(params.dig(:session, :password))
      # Log the user in and redirect to the user's show page.
      reset_session
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      flash[:success] = t(".login_success")
      redirect_to user, status: :see_other
    else
      # Create an error message and re-render the login page.
      flash.now[:danger] = t(".invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash[:success] = t(".logout_success")
    redirect_to root_url, status: :see_other
  end
end
