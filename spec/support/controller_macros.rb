module LoginMacros
  def set_user_sission(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end
