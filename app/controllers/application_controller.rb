class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :set_locale

  def set_locale
    I18n.locale = if params[:lang].blank?  
      current_user &&
          (current_user.locale.blank? ?
            I18n.default_locale : current_user.locale.name)
    else
      params[:lang]
    end
  end
end
