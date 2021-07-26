class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.find_from_auth_hash(auth_hash)
    if user.persisted?
      flash[:success] = "Signed in as #{user.name}"
      sign_in_and_redirect user
    else
      redirect_to new_user_registration_path, alert: 'Error occured'
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end

  alias_method :twitter, :all
end