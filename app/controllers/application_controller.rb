class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
<<<<<<< HEAD
    allowed = I18n.available_locales.map(&:to_s)

    I18n.locale =
      if allowed.include?(params[:locale])
        params[:locale]
      else
        I18n.default_locale
      end
=======
    I18n.locale = params[:locale] || I18n.default_locale
>>>>>>> 3d7a312 (Update pull_request_template.md)
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
