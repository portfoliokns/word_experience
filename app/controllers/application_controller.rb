class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters_sign_up, if: :devise_controller?
  before_action :configure_permitted_parameters_account_update, if: :devise_controller?
  include PointMethod
  before_action :set_word_point_on_sideber

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters_sign_up
    devise_parameter_sanitizer.permit(:sign_up,keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end

  def configure_permitted_parameters_account_update
    devise_parameter_sanitizer.permit(:account_update,keys: [:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end

  def set_word_point_on_sideber
    set_word_point_display
  end

end
