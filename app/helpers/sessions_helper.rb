module SessionsHelper
  # Logs in the given user.
  def log_in user
    session[:user_id] = user.id
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    reset_session
    @current_user = nil
  end

  def delete_session
    session.delete(:user_id)
    session.delete(:session_token)
  end

  def current_user
    @current_user ||= find_user_from_session || find_user_from_cookies
  end

  def current_user? user
    user == current_user
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def remember_session user
    user.remember
    session[:session_token] = user.remember_token
  end

  def redirect_back_or(default, **options)
    redirect_to(session[:forwarding_url] || default, **options)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  private

  def find_user_from_session
    user_id = session[:user_id]
    return nil unless user_id

    user = User.find_by(id: user_id)
    return nil unless user

    session_token = session[:session_token]
    return nil if session_token && !user.authenticated?(session_token)

    user
  end

  def find_user_from_cookies
    user_id = cookies.signed[:user_id]
    return nil unless user_id

    user = User.find_by(id: user_id)
    return nil unless user

    if user.authenticated?(cookies[:remember_token])
      log_in user
      return user
    end

    nil
  end
end
