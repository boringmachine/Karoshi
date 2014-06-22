class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_locale

  def set_locale
    if current_user
      I18n.locale = if current_user.locale.blank?
        I18n.default_locale
      else
        current_user.locale.name
      end
    end
  end
end
