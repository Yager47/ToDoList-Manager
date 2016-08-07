class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    current_user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if current_user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect dashboard_path, :event => :authentication
    else
      flash[:notice] = "authentication error"
      redirect_to root_path
  end

  def vkontakte
  end
end
