class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    return flash["alert"] = "#{provider}のデータがありません。" if request.env["omniauth.auth"].nil?

    @user = User.select_or_create_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "#{provider}")
    else
      redirect_to new_user_registration_url
      flash[:alert] = I18n.t("devise.omniauth_callbacks.failure", kind: "#{provider}")
    end
  end
end
