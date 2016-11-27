class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def authorize

    User.new if User.count.zero?

    unless request.format == Mime::HTML
      authenticate_or_request_with_http_basic do |u,p|
        user = User.find_by_name(u)
        if user and user.authenticate(p)
          session[:user_id] = user.id
        end
      end
      return
    end

    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Пожалуйста, пройдите авторизацию'
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
