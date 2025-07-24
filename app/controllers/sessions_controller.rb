class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)

    if user.try(:authenticate, params.dig(:session, :password))
      # Log the user in and redirect to the user's show page.
      reset_session
      log_in user
      params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
      redirect_to user, status: :see_other
    else
      # Create an error message and re-render the login page.
      flash.now[:danger] = t("sessions.invalid_email_or_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
