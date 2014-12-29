class LanguageController < ApplicationController
  def english
    I18n.locale = :en
    set_language_and_session
  end

  def spanish
    I18n.locale = :es
    set_language_and_session
  end
  
  private
    def set_language_and_session
      session[:locale] = I18n.locale
      redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to :root
    end
end
