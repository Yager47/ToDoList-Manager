class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      sign_in user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      redirect_to dashboard_path
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_path
    end

    # @user = User.find_for_facebook_auth(request.env["omniauth.auth"])
    # if @user.persisted?
    #   flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    #   sign_in @user
    #   redirect_to dashboard_path, :event => :authentication
    #   # sign_in_and_redirect @user, :event => :authentication
    # else
    #   flash[:notice] = "authentication error"
    #   redirect_to root_path
    # end
  end

  def vkontakte
  end
end
