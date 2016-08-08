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
  end

  def vkontakte
  end
end
